function [ F ] = logistica( params,t )
%GOMPERTZA Summary of this function goes here
%   Detailed explanation goes here
A      = params(1);
lambda = params(2);
mu     = params(3);

F = A / (1 + exp( (4 * mu) / A * (lambda - t) + 2 ))


end
