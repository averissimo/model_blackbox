function [ output ] = timeStep( timeEnd , minor_step )
%TIMESTEP Summary of this function goes here
%   Detailed explanation goes here

    start = 0;
    MAX_STEPS = 2500;
    
    if nargin > 1 && minor_step * MAX_STEPS < timeEnd
        resolution = minor_step * 0.5;
    elseif timeEnd == start
        output = start;
        return;
    else
        resolution = ceil(timeEnd) / MAX_STEPS;
    end
    
    output = start:resolution:ceil(timeEnd);
end


