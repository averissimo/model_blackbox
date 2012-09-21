function [ output ] = timeStep( timeEnd , minor_step )
%TIMESTEP Summary of this function goes here
%   Detailed explanation goes here

    MAX_STEPS = 2500;
    
    if nargin > 1 && minor_step * MAX_STEPS < timeEnd
        resolution = minor_step * 0.5;
    else
        resolution = ceil(timeEnd) / MAX_STEPS;
    end
    
    output = 0:resolution:ceil(timeEnd);
    %output = 0:0.01:ceil(timeEnd);
end


