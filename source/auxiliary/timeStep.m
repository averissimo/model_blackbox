function [ output ] = timeStep( timeEnd )
%TIMESTEP Summary of this function goes here
%   Detailed explanation goes here
    output = 0:0.002:ceil(timeEnd);
    output = 0:0.01:ceil(timeEnd);
end

