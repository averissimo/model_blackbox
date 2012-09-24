function [ output ] = time_step( input )
%TIMESTEP Summary of this function goes here
%   Detailed explanation goes here

    if isfield( input, 'start' )
        start = str2double( input.start );
    else
        start = 0;
    end
    
    if isfield( input, 'minor_step' )
        minor_step = str2double( input.minor_step );
    else
        minor_step = 0;
    end
   
    timeEnd = str2double( input.end );

    MAX_STEPS = 2500;
    
    if minor_step > 0 && minor_step * MAX_STEPS < timeEnd + start
        resolution = minor_step * 0.5;
    else
        resolution = ceil(timeEnd) / MAX_STEPS;
    end
    
    if timeEnd == start
        output = start;
    else
        output = start:resolution:ceil(timeEnd);
    end
end


