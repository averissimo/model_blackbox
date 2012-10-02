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
