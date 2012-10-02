function [ F ] = gompertza( params,t )
%GOMPERTZA Summary of this function goes here
%   Detailed explanation goes here
 F = params(4) + ( params(1) .* exp( -exp( (params(3) .* exp(1) ./ params(1)) .* (params(2) - t) + 1 ) ) );
 if size(F,1) > 1 F = F'; end
end

