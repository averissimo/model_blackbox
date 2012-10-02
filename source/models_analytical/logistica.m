function [ F ] = logistica( params,t )
%GOMPERTZA Summary of this function goes here
%   Detailed explanation goes here
A      = params(1);
lambda = params(2);
mu     = params(3);
N      = params(4);

F = N + A ./ (1 + exp( (4 * mu) ./ A * (lambda - t) + 2 ));
if size(F,1) > 1 F = F'; end
end
