% Model Blackbox
% Copyright (C) 2012-2012  André Veríssimo
%
% This program is free software; you can redistribute it and/or
% modify it under the terms of the GNU General Public License
% as published by the Free Software Foundation; version 2
% of the License.
%
% program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program; if not, write to the Free Software
% Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

function TEMPLATE_est()
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
