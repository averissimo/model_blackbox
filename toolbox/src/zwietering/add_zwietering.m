function [ new_string ] = add_zwietering( status, string, y_0, x_0)
%ADD_ZWIETERING Summary of this function goes here
%   Detailed explanation goes here

    new_string = string;
    if status == 0
        new_string = strrep( new_string, '}', ',');
        %output_string(length(output_string)) = ',';
        new_string = strcat( new_string, sprintf('\n\t"N_0": %.14f,\n', y_0));
        new_string = strcat( new_string, sprintf('\t"t_0": %.14f\n', x_0));
        new_string = strcat( new_string, '}');
    end
    
end

