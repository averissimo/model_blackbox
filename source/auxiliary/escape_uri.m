% Model Blackbox
% Copyright (C) 2012-2012  André Veríssimo
%
% This program is free software; you can redistribute it and/or
% modify it under the terms of the GNU General Public License
% as published by the Free Software Foundation; version 2
% of the License.
%
% program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program; if not, write to the Free Software
% Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

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
