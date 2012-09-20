function [ output_args ] = escape_uri( input_args )
%ESCAPE_URI Summary of this function goes here
%   Detailed explanation goes here

    if isstruct( input_args )
        names = fieldnames( input_args );
        len = length(names);
        output_args = struct;
        for i = 1:len
            output_args.( char( names(i) )) = escape_uri_string( input_args.( char( names(i) )) );
        end
    elseif ischar( input_args )
        output_args = escape_uri_string( input_args );
    end
    
    function output = escape_uri_string( string )
        output = strrep(string , '%2C' , ',');
        %output = strrep(output, '%5D' , ']');
        %output = strrep(output, '%5B' , '[');
        output = strrep(output, '%5D' , '');
        output = strrep(output, '%5B' , '');
        output = strrep(output, '%3B' , ';');
        output = strrep(output, '%7D' , '}');
        output = strrep(output, '%7B' , '{');
        output = strrep(output, '+' , ' ');
        output = strrep(output, '%20' , ' ');
    end
end

