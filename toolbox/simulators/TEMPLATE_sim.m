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

function TEMPLATE_sim( )
%BARANYI Summary of this function goes here
%   Detailed explanation goes here
%#function SBPDsimulate

%
% example:
% setenv('QUERY_STRING','miu=1.266&lambda=3.78826&A=0.665752&end=23&x_0=0.146912');
input = qs2struct(getenv('QUERY_STRING'));

Gompertz('parameters');

MEXmodel_global = 'Gompertz';

try
    %
    miu     = str2double( input.miu );
    lambda  = str2double( input.lambda );
    A       = str2double( input.A );
    TimeEnd = timeStep( str2double( input.end ) );
    N       = str2double( input.N );
    %
    inicond = [N , 0];
    parameters = {'miu' 'lambda' 'A' };
    paravalues = [miu lambda A];
    %
    [~, simdata]=evalc(sprintf('SBPDsimulate(MEXmodel_global,TimeEnd,inicond,parameters,paravalues);'));
    %simdata = SBPDsimulate(MEXmodel_global,TimeEnd,inicond,parameters,paravalues);
    %
    M = [ simdata.statevalues(:,2) simdata.statevalues(:,1)];
    printJson(M)
catch err
    msg = sprintf('{ "error": "%s" }\n',err.message);
    printHeader(length(msg));
    fprintf(1,'%s',msg);
end

end
