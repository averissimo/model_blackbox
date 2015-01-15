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
function string_output=print_error_json( err , fid, remove_bracket )
%PRINT_ERROR_JSON Summary of this function goes here
%   Detailed explanation goes here
    string_output = '';
    if nargin <= 2 || not(remove_bracket)
        string_output = strcat(string_output,sprintf('{\n'));
    end
    string_output = strcat(string_output,sprintf('\t"error":\t"%s",\n',err.message));
    len = length(err.stack);
    for i = 1:len
        string_output = strcat(string_output,sprintf('\t"stack_%d": {\n\t\t"line": "%d",\n\t\t"name": "%s",\n\t\t"file": "%s"\n\t', i, err.stack(i).line, err.stack(i).name  , err.stack(i).file));
        if i ~= len, string_output = strcat(string_output,sprintf('},\n')); end
    end
    string_output = strcat(string_output,sprintf('}\n}\n'));
    %fprintf(fid,string_output);
end
