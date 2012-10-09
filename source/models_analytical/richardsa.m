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
