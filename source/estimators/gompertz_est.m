function gompertz_est()
%% declare functions that will be called
%$function est_gompertz
%#function mex
%#function simplexSB
%#function defaultcostparameterestimationSBPD
%#function SBPDparameterestimation

%
% example:
% setenv('QUERY_STRING','time=[0.0,1.167,2.0,3.167,4.083,5.333,6.333,7.25,8.25,9.0,9.917,11.0,11.833]&values=[0.052,0.074,0.104,0.155,0.205,0.283,0.38,0.447,0.618,0.715,0.792,0.923,0.953]&estimation=%7B"states":[%7B"name":"A","bottom": 0.3,"top":15%7C,%7B"name":"miu","bottom":0,"top":2%7C,%7B"name":"lambda","bottom":0,"top":4%7C],"initial":[%7B"name":"N","bottom":0,"top":1%7C,%7B"name":"t","bottom":0,"top":100%7C]%7C')
%setenv('QUERY_STRING','time=[0,1.167,2,3.167,4.083,5.333,6.333,7.25,8.25,9,9.917,11,11.833,26.75];[0,1.167,2,3.167,4.083,5.333,6.333,7.25,8.25,9,9.917,11,11.833,26.75]&values=[1.052,1.074,1.104,1.155,1.205,1.283,1.38,1.447,1.618,1.715,1.792,1.923,1.953,1.873];[0.052,0.074,0.104,0.155,0.205,0.283,0.38,0.447,0.618,0.715,0.792,0.923,0.953,0.873]&estimation=%7B"states":[%7B"name":"A","bottom":0.3,"top":30.0%7D,%7B"name":"lambda","bottom":-2.0,"top":5.0%7D,%7B"name":"miu","bottom":0.0,"top":3.0%7D],"initial":[%7B"name":"N","bottom":0.0001,"top":2.01%7D,%7B"name":"t","bottom":0,"top":100%7D]%7D');


%% get inputs
% input paramters are in the environment variable "QUERY_STRING"
input = qs2struct(getenv('QUERY_STRING'));
% The HTML page returns the field "size"
%  which is now stored in input.size as a string
%  This is passed to the mymagic function 
%  to compute the magic square.
global MEXmodel_global  MEXmodelfullpath_global MEX_DO_NOT_CREATE;

MEX_DO_NOT_CREATE = 1;
Gompertz('parameters');
MEXmodel_global = 'Gompertz';
MEXmodelfullpath_global = strcat( fileparts(mfilename('fullpath')) , '/../lib/');

try
    %% html header
    printHeader( 0 );
    %%
    %
%% experiments
    experiments = struct( 'name' , 'test', 'notes' , '', 'experiment' , SBexperiment, 'measurements' , '');
    
    %% measurements
    % multiple measurements for one experiment
    time_s_array = textscan(input.time,'%s','delimiter',';');
    value_s_array = textscan(input.values,'%s','delimiter',';');
    len = length(time_s_array{1});
    
    for i = 1:len
        time = str2num(char(time_s_array{1}(i)));
        values = str2num(char(value_s_array{1}(i)));
        str = SBstruct(SBmeasurement());
        str.name = 'estimation';
        str.notes = '';
        str.time = time;
        maxmin = NaN(size(values,1),1);
        str.data = struct( 'name' , 'N' ,  'notes' , [] , 'values', values , 'maxvalues', maxmin , 'minvalues' , maxmin );
        measurement = SBmeasurement( str );
        %
        %% project
        experiments.measurements{i} = measurement;
    
    end
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
    
catch err
    msg = sprintf('{ "error": "%s" }\n',err.message);
    printHeader(length(msg));
    fprintf(1,'%s',msg);
end

end

