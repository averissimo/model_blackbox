% Model Blackbox
% Copyright (C) 2014  afsverissimo@gmail.com
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

function [ F ] = reversible_hills_equationa( params,t )
%reversible_hills_equationa Summary of this function goes here

%% model parameters are extracted below
KA  = params(1);
KeqPK  = params(2);
KI  = params(3);
KmADP  = params(4);
KmATP  = params(5);
KmPEP  = params(6);
KmPYR  = params(7);
n  = params(8);
s  = params(9);
t  = params(10);
vmax_PK  = params(11);

%% function
F = (vmax_PK .* PEP/KmPEP .* ADP/KmADP .* (1 - KeqPK .* (ATP .* PYR) ./ (ADP .* PEP))) .* (PEP ./ KmPEP + PYR ./ KmPYR).^(n-1) .* (ADP ./ KmADP + ATP ./ KmATP).^(n-1) ./ ( ((1 + (x./KI).^n + (A./KA).^n)./(1 + t.*(x./KI).^n + s * (A ./ KA).^n) + C2.^n) .* (((1 + (x./KI).^n + (A./KA).^n)./(1 + t.*(x./KI).^n + s * (A ./ KA).^n)) + (ADP ./ KmADP + ATP ./ KmATP).^n) );
if size(F,1) > 1 F = F'; end

end
