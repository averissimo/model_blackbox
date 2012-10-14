function [ F ] = testa( params , t)
%GOMPERTZA Summary of this function goes here
%   Detailed explanation goes here
a   = params(1);
b   = params(2);

F = a + b .* t .* t;




% uniform results
if size(F,1) > 1 F = F'; end

end
