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

function x = qs2struct( qs )
% return the query string as a structure
% each field is a paramter name
% the value of the field is its value as a string

    % an example query string:
    % myinput=test&size=2&num=10

    % get the indeces of the characters that divide names and fields
    div = [0,strfind(qs,'&'),length(qs)+1];
    eq = strfind(qs,'=');

    x.querystring = qs;
    for i=1:length(eq)
        field = qs(div(i)+1:eq(i)-1); %field string
        value = qs(eq(i)+1:div(i+1)-1); %value stirng
        x = setfield(x,field,value); %place in structure
    end

end
