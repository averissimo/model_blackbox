function [ output ] = timeStep( timeEnd )
%TIMESTEP Summary of this function goes here
%   Detailed explanation goes here

    MAX_STEPS = 2500;
    
    resolution = ceil(timeEnd) / MAX_STEPS;
    
    output = 0:resolution:ceil(timeEnd);
    %output = 0:0.01:ceil(timeEnd);
end


