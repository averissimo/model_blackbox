function baranyi_est()
%% declare functions that will be called
%$function est_gompertz
%#function mex
%#function simplexSB
%#function defaultcostparameterestimationSBPD
%#function SBPDparameterestimation

%
% example:
%qs.time='[0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0];[0.0,1.0,2.0,3.0,4.0,5.0];[0.0,1.0,2.1,3.0,4.1,5.1,6.0,7.0];[0.0,1.0,2.1,3.0,4.1,5.1,6.0,7.0];[0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0];[0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0,25.6];[0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.05];[0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.05,23.42];[0.0,1.317,2.0,2.983,3.983,4.917,6.0];[0.0,0.917,2.083,2.917,4.083,5.0,6.167,7.25]';
%qs.values='[0.04,0.113,0.363,0.924,1.632,2.288,2.172,2.188];[0.06,0.244,0.528,1.28,2.192,2.188];[0.068,0.143,0.391,0.994,1.78,2.268,2.336,2.308];[0.055,0.116,0.27,0.6,1.348,2.04,2.292,2.272];[0.067,0.157,0.396,0.962,1.828,1.996,2.032,1.952];[0.07,0.139,0.404,0.994,1.884,2.044,2.1,1.92,1.932];[0.06,0.12,0.29,0.77,1.64,2.42,2.515,2.4];[0.06,0.13,0.34,0.91,1.81,2.03,2.535,2.47,2.5];[0.049,0.142,0.274,0.682,1.448,1.952,2.296];[0.052,0.091,0.288,0.63,1.437,2.07,2.352,2.22]';

%qs.h0.bottom='0.0354086';
%qs.h0.top='3.54086';
%qs.m.bottom='-5.47651';
%qs.m.top='47.651';
%qs.mu.bottom='0.020515';
%qs.mu.top='15';
%qs.v.bottom='-5.0147768';
%qs.v.top='1.47768';
%qs.y0.bottom='-5.244751';
%qs.y0.top='24.4751';
%qs.ymax.bottom='0.458376';
%qs.ymax.top='30.8376';
%qs.N.bottom='-10';
%qs.N.top='30';
%qs.t.bottom='0';
%qs.t.top='100';

%query = sprintf('time=%s&values=%s&estimation=%%7B%%22states%%22:[%%7B%%22name%%22:%%22h0%%22,%%22bottom%%22:%s,%%22top%%22:%s%%7D,%%7B%%22name%%22:%%22m%%22,%%22bottom%%22:%s,%%22top%%22:%s%%7D,%%7B%%22name%%22:%%22mu%%22,%%22bottom%%22:%s,%%22top%%22:%s%%7D,%%7B%%22name%%22:%%22v%%22,%%22bottom%%22:%s,%%22top%%22:%s%%7D,%%7B%%22name%%22:%%22y0%%22,%%22bottom%%22:%s,%%22top%%22:%s%%7D,%%7B%%22name%%22:%%22ymax%%22,%%22bottom%%22:%s,%%22top%%22:%s%%7D],%%22initial%%22:[%%7B%%22name%%22:%%22N%%22,%%22bottom%%22:%s,%%22top%%22:%s%%7D,%%7B%%22name%%22:%%22t%%22,%%22bottom%%22:%s,%%22top%%22:%s%%7D]%%7D',qs.time,qs.values,qs.h0.bottom,qs.h0.top,qs.m.bottom,qs.m.top,qs.mu.bottom,qs.mu.top,qs.v.bottom,qs.v.top,qs.y0.bottom,qs.y0.top,qs.ymax.bottom,qs.ymax.top,qs.N.bottom,qs.N.top,qs.t.bottom,qs.t.top);
%setenv('QUERY_STRING',query)
%setenv('QUERY_STRING','time=[0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0];[0.0,1.0,2.0,3.0,4.0,5.0];[0.0,1.0,2.1,3.0,4.1,5.1,6.0,7.0];[0.0,1.0,2.1,3.0,4.1,5.1,6.0,7.0];[0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0];[0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0,25.6];[0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.05];[0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.05,23.42];[0.0,1.317,2.0,2.983,3.983,4.917,6.0];[0.0,0.917,2.083,2.917,4.083,5.0,6.167,7.25]&values=[0.04,0.113,0.363,0.924,1.632,2.288,2.172,2.188];[0.06,0.244,0.528,1.28,2.192,2.188];[0.068,0.143,0.391,0.994,1.78,2.268,2.336,2.308];[0.055,0.116,0.27,0.6,1.348,2.04,2.292,2.272];[0.067,0.157,0.396,0.962,1.828,1.996,2.032,1.952];[0.07,0.139,0.404,0.994,1.884,2.044,2.1,1.92,1.932];[0.06,0.12,0.29,0.77,1.64,2.42,2.515,2.4];[0.06,0.13,0.34,0.91,1.81,2.03,2.535,2.47,2.5];[0.049,0.142,0.274,0.682,1.448,1.952,2.296];[0.052,0.091,0.288,0.63,1.437,2.07,2.352,2.22]&estimation=%7B"states":[%7B"name":"h0","bottom":-5.0,"top":5.0%7D,%7B"name":"m","bottom":-5.0,"top":5.0%7D,%7B"name":"mu","bottom":0.0,"top":3.0%7D,%7B"name":"v","bottom":-5.0,"top":5.0%7D,%7B"name":"y0","bottom":-5.0,"top":5.0%7D,%7B"name":"ymax","bottom":0.0,"top":10.0%7D],"initial":[%7B"name":"N","bottom":0.0,"top":0.0%7D,%7B"name":"t","bottom":0,"top":100%7D]%7D');

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
    %% model
    model = SBmodel( strcat('models/',MEXmodel_global,'.txt') );
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
