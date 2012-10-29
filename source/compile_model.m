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

function compile_model(model_path)
%% declare functions that will be called
%$function est_gompertz
%#function mex
%#function simplexSB
%#function defaultcostparameterestimationSBPD
%#function SBPDparameterestimation

global MEXmodel_global MEXmodelfullpath_global MEX_DO_NOT_CREATE;

MEX_DO_NOT_CREATE = 0;
MEXmodelfullpath_global = strcat(pwd,'/lib/');
try
    %% html header
    printHeader( 0 );
    %
    %% measurements
    %% model
    model = SBmodel( model_path );
    struct = SBstruct(model);
    MEXmodel_global = struct.name;
    makeTempMEXmodelSBPD( model );

    fprintf(1,'mex model can be located at\n');
    fprintf(1,'%s%s.mexglx\n',MEXmodelfullpath_global,MEXmodel_global);
catch e
    fprintf(1,'{ "error": "%s" }\n',e.message);
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
