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

function [ F ] = reversible_hills_equationa( params,I )
%reversible_hills_equationa Summary of this function goes here

%% model parameters are extracted below
%% model parameters are extracted below
KA      = params(01);
KeqPK   = params(02);
KI      = params(03);
KmADP   = params(04);
KmATP   = params(05);
KmPEP   = params(06);
KmPYR   = params(07);
n       = params(08);
s       = params(09);
t       = params(10);
vmax_PK = params(11);

PEP     = 2;
ADP     = 5;
ATP     = 2;
PYR     = 0;
A       = 2;


C1 = vmax_PK .* PEP/KmPEP .* ADP/KmADP .* (1 - KeqPK .* (ATP .* PYR) ./ (ADP .* PEP));
C2 = PEP ./ KmPEP + PYR ./ KmPYR;
C3 = ADP ./ KmADP + ATP ./ KmATP;
E1 = 1 + (I./KI).^n + (A./KA).^n;
E2 = 1 + t.*(I./KI).^n + s * (A ./ KA).^n;

F = C1 .* C2.^(n-1) .* C3.^(n-1) ./ ( (E1./E2 + C2.^n) .* ((E1./E2) + C3.^n) );

t_2 = t;
t = I;
%F = (vmax_PK .* 2/KmPEP .* 5/KmADP .* (1 - KeqPK .* (2 .* 0) ./ (5 .* 2))) .* (2 ./ KmPEP + 0 ./ KmPYR).^(n-1) .* (5 ./ KmADP + 2 ./ KmATP).^(n-1) ./ ( ((1 + (t./KI).^n + (2./KA).^n)./(1 + t_2.*(t./KI).^n + s * (2 ./ KA).^n) + (2 ./ KmPEP + 0 ./ KmPYR).^n) .* (((1 + (t./KI).^n + (2./KA).^n)./(1 + t_2.*(t./KI).^n + s * (2 ./ KA).^n)) + (5 ./ KmADP + 2 ./ KmATP).^n) );

if size(F,1) > 1
    F = F';
end

end
