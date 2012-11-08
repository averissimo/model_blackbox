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

function [ F ] = richardsa( params,t )
%GOMPERTZA Summary of this function goes here
%   Detailed explanation goes here
A      = params(1);
lambda = params(2);
mu     = params(3);
N      = params(4);
v      = params(5);

F = N + A * ( 1 + v * exp( 1 + v ) * exp( mu ./ A * (1 + v) * (1 + 1 ./ v) * (lambda - t) ) ).^(-1 ./ v);
if size(F,1) > 1 F = F'; end
end
