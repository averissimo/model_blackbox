function baranyi_est()
%% declare functions that will be called
%$function est_gompertz
%#function mex
%#function simplexSB
%#function defaultcostparameterestimationSBPD
%#function SBPDparameterestimation

%
% example:
%qs.time='[0.0,1.05,2.3,3.0,4.0,5.05,6.05,7.05,8.0,9.05,10.05]';
%qs.values='[0.053,0.065,0.092,0.129,0.198,0.326,0.536,0.658,0.884,0.978,0.91]';
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
setenv('QUERY_STRING',query)

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
    experiments = struct( 'name' , 'test', 'notes' , '', 'experiment' , SBexperiment, 'measurements' , '');
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
    %[~,output] = evalc('SBPDparameterestimation(project,estimation,1);');
    output= SBPDparameterestimation(project,estimation,1);
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