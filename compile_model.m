function compile_model()
%% declare functions that will be called
%$function est_gompertz
%#function mex
%#function simplexSB
%#function defaultcostparameterestimationSBPD
%#function SBPDparameterestimation

%% get inputs
% input paramters are in the environment variable "QUERY_STRING"
input = qs2struct(getenv('QUERY_STRING'));
% The HTML page returns the field "size"
%  which is now stored in input.size as a string
%  This is passed to the mymagic function 
%  to compute the magic square.

global MEXmodel_global MEXmodelfullpath_global MEX_DO_NOT_CREATE;

%MEXmodel_global = 'est_gompertz_test2';
%MEXmodelfullpath_global = '/home/dev/work/pneumosys/matlab/standalone_estimation/lib/';

MEX_DO_NOT_CREATE = 1;
MEXmodel_global = 'est_gompertz_2';
MEXmodelfullpath_global = '/home/dev/work/pneumosys/matlab/standalone_estimation/lib/';

try
    %% html header
    printHeader( 0 );
    %
    %% measurements
    time = str2num(input.time)';
    values = str2num(input.values)';
    str = SBstruct(SBmeasurement());
    str.name = 'estimation';
    str.notes = '';
    str.time = time;
    maxmin = NaN(size(values,1),1);
    str.data = struct( 'name' , 'N' ,  'notes' , [] , 'values', values , 'maxvalues', maxmin , 'minvalues' , maxmin );
    measurement = SBmeasurement( str );
    %
    %% model
    json=loadjson(input.model);
    j_model = json.model;
    %
    model = SBmodel( build_model(j_model) );
    makeTempMEXmodelSBPD( model );
    
    %%%% project
    %%experiments = struct( 'name' , 'test', 'notes' , '', 'experiment' , [SBexperiment], 'measurements' , '');
    %%experiments.measurements = { measurement };
    %%%
    %%proj_s = struct(SBPDproject());
    %%proj_s.experiments = experiments;
    %%proj_s.models = {model};
    %%%
    %%project = SBPDproject(proj_s);
    %%%% estimation
    %%estimation = build_estimation( loadjson( input.estimation ) );
    %%% calls evalc and avoids verbose output
    %%[~,output] = evalc('SBPDparameterestimation(project,estimation,1);');
    %%%output= SBPDparameterestimation(project,estimation,1);
    %%len = length(output.parameters);
    %%fprintf(1,'{\n');
    %%for x = 1:len
    %%    fprintf(1,'\t"%s": %f',output.parameters{x},output.Popt(x));
    %%    fprintf(1,',\n');
    %%end
    %%len = length(output.icnames);
    %%for x = 1:len
    %%    fprintf(1,'\t"%s": %f',output.icnames{x},output.ICopt(x));
    %%    if x ~= len
    %%        fprintf(1,',\n');
    %%    end
    %%end
    %%fprintf(1,'\n');
    %%fprintf(1,'}\n');
    fprintf(1,'mex model can be located at\n');
    fprintf(1,'%s%s.mexglx\n',MEXmodelfullpath_global,MEXmodel_global);
catch e
    fprintf(1,'{ "error": "%s" }\n',e.message);
    %fprintf(1,'{ "error": "%s" }\n',e.stack(0).file);
end

end

function printHeader(len)
fprintf(1,'Content-type: application/json; charset=utf-8\n');
fprintf(1,'Cache-control: max-age=0, private, must-revalidate\n');
if ( len > 0)
    fprintf(1,'Content-length: %i\n',len);
end
fprintf(1,'Access-Control-Allow-Origin: *\n');


fprintf(1,'\r\n');
end
function printJson(M)
json = savejson('result',M);
printHeader( length(json) );
fprintf(1,'%s',json);
end
function x=qs2struct(qs)
% return the query string as a structure
% each field is a paramter name
% the value of the field is its value as a string

% an example query string:
% myinput=test&size=2&num=10

% get the indeces of the characters that divide names and fields
div = [0,strfind(qs,'&'),length(qs)+1];
eq = strfind(qs,'=');

x.querystring = qs;
for i=1:length(eq)
    field = qs(div(i)+1:eq(i)-1); %field string
    value = qs(eq(i)+1:div(i+1)-1); %value stirng
    x = setfield(x,field,value); %place in structure
end
end
function model = build_model( json_model )
%BUILD_MODEL Summary of this function goes here
%   Detailed explanation goes here

    model = SBstruct(SBmodel());
    names = fieldnames(model);
    has_name = isfield( json_model , names );
    
    arrayfun( @(x,y)( first( x,y) ), has_name , names);
    
    % first level function
    function first( x, y )
        if x == 1
            if isstruct(model.(char(y)))
                names_2 = fieldnames(model.(char(y)));
                has_name_2 = isfield(json_model.(char(y)) , names_2);
                arrayfun( @(z,w)( second(z,y,w) ) , has_name_2 , names_2 );
            end
            model.(char(y)) = json_model.(char(y));
        end
    end
    % second level function
    function second( z , k, w )
        if z == 0
            size = length( json_model.(char(k)) );
            for c = 1:size
               json_model.(char(k))(c).(char(w)) = '';
            end
        end
    end   
end

function estimation=build_estimation(params)

%% DEFINE THE ESTIMATION INFORMATION (STRUCTURE)
estimation = [];
% Global parameters
% Names    Lower bounds  Upper bounds
len = length(params.states);
paramdata = cell(len,3);
for x = 1:len
    paramdata{x,1} = params.states(x).name;
    paramdata{x,2} = params.states(x).bottom;
    paramdata{x,3} = params.states(x).top;
end
% Initial conditions (always experiment dependend)
% Names    Lower bounds  Upper bounds
len = length(params.initial);
icdata = cell(len,3);
for x = 1:len
    icdata{x,1} = params.initial(x).name;
    icdata{x,2} = params.initial(x).bottom;
    icdata{x,3} = params.initial(x).top;
end
% Local (experiment dependend) parameters
% Names    Lower bounds  Upper bounds
paramdatalocal = {
};

% Model and experiment settings
estimation.modelindex = 1;
estimation.experiments.indices = [1];
estimation.experiments.weight = [1];

% Optimization settings
estimation.optimization.method = 'simplexSB';
estimation.optimization.options.maxfunevals = 2000;

% Integrator settings
estimation.integrator.options.abstol = 1e-006;
estimation.integrator.options.reltol = 1e-006;
estimation.integrator.options.minstep = 0;
estimation.integrator.options.maxstep = Inf;
estimation.integrator.options.maxnumsteps = 1000;

% Flags
estimation.displayFlag = 2; % show iterations and final message
estimation.scalingFlag = 2; % scale by mean values
estimation.timescalingFlag = 0; % do not apply time-scaling
estimation.initialconditionsFlag = 1; % do use initial conditions from measurement data (if available)

% Always needed (do not change ... unless you know what you do)
estimation.parameters = paramdata;
estimation.parameterslocal = paramdatalocal;
estimation.initialconditions = icdata;

end
