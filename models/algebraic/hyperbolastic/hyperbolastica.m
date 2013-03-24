% Model Blackbox
% Copyright (C) 2013  afsverissimo@gmail.com
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

function [ F ] = hyperbolastica( params,t )
%hyperbolastic_growth_model_of_type_iii_h3a Summary of this function goes here

%% model parameters are extracted below
d  = params(1);
g  = params(2);
M  = params(3);
P0  = params(4);
theta  = params(5);

%% function
F = M-(M-P0)*exp(-d*t.^g-asinh(theta*t));
if size(F,1) > 1 F = F'; end

end
