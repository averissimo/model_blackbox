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
        output = regexprep(string , '%2C' , ',', 'ignorecase');
        %output = regexprep(output, '%5D' , ']', 'ignorecase');
        %output = regexprep(output, '%5B' , '[', 'ignorecase');
        output = regexprep(output, '\[' , '', 'ignorecase');
        output = regexprep(output, '\]' , '', 'ignorecase');
        output = regexprep(output, '%5D' , '', 'ignorecase');
        output = regexprep(output, '%5B' , '', 'ignorecase');
        output = regexprep(output, '%3B' , ';', 'ignorecase');
        output = regexprep(output, '%7D' , '}', 'ignorecase');
        output = regexprep(output, '%7B' , '{', 'ignorecase');
        output = regexprep(output, '\+' , ' ', 'ignorecase');
        output = regexprep(output, '%20' , ' ', 'ignorecase');
    end
end

