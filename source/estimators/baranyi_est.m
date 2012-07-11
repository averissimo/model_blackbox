function baranyi_est()
%% declare functions that will be called
%$function est_gompertz
%#function mex
%#function simplexSB
%#function defaultcostparameterestimationSBPD
%#function SBPDparameterestimation

%
% example:
% setenv('QUERY_STRING','time=[0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0]&values=[0.04,0.113,0.363,0.924,1.632,2.288,2.172,2.188]&estimation=%7B%22states%22:[%7B%22name%22:%22h0%22,%22bottom%22:-5.0,%22top%22:5.0%7D,%7B%22name%22:%22m%22,%22bottom%22:-5.0,%22top%22:5.0%7D,%7B%22name%22:%22mu%22,%22bottom%22:0.0,%22top%22:3.0%7D,%7B%22name%22:%22v%22,%22bottom%22:-5.0,%22top%22:5.0%7D,%7B%22name%22:%22y0%22,%22bottom%22:-5.0,%22top%22:5.0%7D,%7B%22name%22:%22ymax%22,%22bottom%22:0.0,%22top%22:10.0%7D],%22initial%22:[%7B%22name%22:%22N%22,%22bottom%22:0.0,%22top%22:0.0%7D,%7B%22name%22:%22t%22,%22bottom%22:0,%22top%22:100%7D]%7D')

%% get inputs
% input paramters are in the environment variable "QUERY_STRING"
input = qs2struct(getenv('QUERY_STRING'));
% The HTML page returns the field "size"
%  which is now stored in input.size as a string
%  This is passed to the mymagic function 
%  to compute the magic square.
global MEXmodel_global  MEXmodelfullpath_global MEX_DO_NOT_CREATE;

MEX_DO_NOT_CREATE = 1;
Baranyi('parameters');
MEXmodel_global = 'Baranyi';
MEXmodelfullpath_global = strcat( fileparts(mfilename('fullpath')) , '/../lib/');

try
    %% html header
    printHeader( 0 );
    %%
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
    model = SBmodel( strcat('models/',MEXmodel_global,'.txt') );
    %% project
    experiments = struct( 'name' , 'test', 'notes' , '', 'experiment' , [SBexperiment], 'measurements' , '');
    experiments.measurements = { measurement };
    %
    proj_s = struct(SBPDproject());
    proj_s.experiments = experiments;
    proj_s.models = {model};
    %
    project = SBPDproject(proj_s);
    %% estimation
    estimat = strrep(input.estimation, '%22' , '"');
    estimat = strrep(estimat, '%7B' , '{');
    estimat = strrep(estimat, '%7D' , '}');
    estimation = build_estimation( loadjson( estimat ) );

    % calls evalc and avoids verbose output
    [~,output] = evalc('SBPDparameterestimation(project,estimation,1);');
    %output= SBPDparameterestimation(project,estimation,1);
    len = length(output.parameters);
    fprintf(1,'{\n');
    for x = 1:len
        fprintf(1,'\t"%s": %f',output.parameters{x},output.Popt(x));
        fprintf(1,',\n');
    end
    len = length(output.icnames);
    for x = 1:len
        fprintf(1,'\t"%s": %f',output.icnames{x},output.ICopt(x));
%        if x ~= len
            fprintf(1,',\n');
%        end
    end
    fprintf(1,'\t"o": %f\n',output.FVALopt);
    fprintf(1,'\n');
    fprintf(1,'}\n');
    close all;
    
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

