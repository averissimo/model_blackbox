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

function [ F ] = baranyia( params , t )
%BARANYIA Summary of this function goes here
%   Detailed explanation goes here
h0   = params(1);
m    = params(2);
mu   = params(3);
v    = params(4);
y0   = params(5);
ymax = params(6);

F2 = ( 1 ./ mu ) .* log( exp(-v .* t) + exp(-h0) - exp(-v .* t - h0) );
F = y0 + mu .* t + F2 - (1 ./ m) *  log( 1 + ( exp( m .* mu .* t + F2) - 1 ) ./ exp(m .* (ymax -y0) ) );
if size(F,1) > 1 F = F'; end

end
