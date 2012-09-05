function [ F ] = baranyia( params,t )
%GOMPERTZA Summary of this function goes here
%   Detailed explanation goes here
a      = params(1);
k      = params(2);
l      = params(3);
p      = params(4);

% not modified
F = a * ( 1 + exp( - (l-k*t)/p ) )^(-p);

end
