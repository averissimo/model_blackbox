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

function [ F ] = schnutea( params,t )
%GOMPERTZA Summary of this function goes here
%   Detailed explanation goes here
a      = params(1);
b      = params(2);
lambda = params(3);
mu     = params(4);
N      = params(5);

F = N + (mu * ( 1 - b ) ./ a ) * ( (1 - b * exp(a * lambda + 1 - b - a * t ) ) ./ ( 1 - b ) ) .^ (1/b);
if size(F,1) > 1 F = F'; end
end
