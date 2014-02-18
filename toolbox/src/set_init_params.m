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

function [higherbound,lowerbound,beta0] = set_init_params(res, index, estimation )
    higherbound = zeros( length(res) , 1);
    lowerbound = zeros( length(res) , 1);
    bounds = zeros( length(res) , 2);
    beta0 = zeros( length(res) , 1);
    for j = 1:length(res)
        lowerbound(j) = estimation.parameters.lowbounds(index(j),1);
        higherbound(j) = estimation.parameters.highbounds(index(j),1);
        if lowerbound(j) == higherbound(j)
           higherbound(j) =  higherbound(j) + abs( higherbound(j)*0.001 );
        end
        beta0( j ) = lowerbound( j ) + rand*( higherbound( j )-lowerbound( j ) );
    end
end
