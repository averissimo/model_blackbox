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

function [ F ] = logisticsa( params,t )
%logisticsa Summary of this function goes here

%% model parameters are extracted below
A  = params(1);
lambda  = params(2);
miu  = params(3);

%% function
F = A ./ (1 + exp( (4 * miu) ./ A * (lambda - t) + 2 ));
if size(F,1) > 1 F = F'; end

end