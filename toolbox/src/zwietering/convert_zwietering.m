function [ new_input, y_0, x_0 ] = convert_zwietering( input )
%CONVERT Summary of this function goes here
%   Detailed explanation goes here
    
    new_input = input;
    try
    %% Convert Y axis to ln(x)/ln(X0)
    % extract time and values
    % convert values
    % write back to input form
    [time,values_aux] = extract_time_values(new_input);
    y_0 = values_aux(1);
    x_0 = time(1);
    values = values_aux - y_0; % ln(x/x0) = ln(x)-ln(x0)
    time_s = '';
    values_s = '';
    for i = 1:(length(values)-1)
        time_s   = strcat( time_s,   sprintf('%f,', time(i)) );
        values_s = strcat( values_s, sprintf('%f,', values(i)) );
    end
    time_s   = strcat( '[', time_s,   sprintf('%f', time(length(values))),   ']' );
    values_s = strcat( '[', values_s, sprintf('%f', values(length(values))), ']' );
    new_input.time   = time_s;
    new_input.values = values_s;
    
    catch
       err_sqr = lasterror();
    end

end

