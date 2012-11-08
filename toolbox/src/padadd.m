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

function [output] = padadd(A, x, index)
% PADADD  Adds data columns to an array even column lengths don't match.
%   Missmatched areas of data array are padded with NaNs.
%
%   answer = padadd(A, x)
%     appends "x" column vector as the last column of "A"
%
%   answer = padadd(A, x, index)
%     assigns "x" to the column specified by "index" in "A"
%     by overwriting any existing data.
%
%   If "x" is a matrix, "index" specifies the leftmost column written to.
%
%   The result is saved recursively to "A" if the output argument is omitted
%   and "A" is a defined variable
%
%Example:
% padadd( eye(2,2), 2*ones(4,1) )
%
%     ans =
%
%          1     0     2
%          0     1     2
%        NaN   NaN     2
%        NaN   NaN     2
%
%Author: HDJ

%check input argument number
if (nargin < 2)
   error('not enough input arguments')
end

%transpose 'x' if it is a row vector
if (size(x,1) == 1) | (size(x,2) == 1) & (size(x,2) > size(x,1))
   x = x';
end

%get sizes of 'A' and 'x'
dAr = size(A,1);
dAc = size(A,2);
dxr = size(x,1);
dxc = size(x,2);


if nargin == 2
   %if index is not specified
   %index = dAc + 1;  %default to adding a column to the end
   index = dAc + (1:dxc); %default to adding all columns to the end
else
   %create index array from index argument
   index = index(1)+ (0:dxc-1);
end

%%%%%%BEGIN PADDING SECTION%%%%%%
%if index is outside current size of 'A' then pad whole columns of 'A'
if dAc < index(end)
   answer = [A,NaN*ones(dAr,index(end)-dAc)];
else
   answer = A;
end

%if 'x' is shorter or the same height as 'A' then pad 'x' as necessary
if dAr >= dxr,
   %answer(:,index) = [ x(:,1); NaN*ones(dAr-dxr,1)];
   answer(:,index) = [ x; NaN*ones(dAr-dxr,dxc)];
end

%if 'x' is taller than 'A' then pad 'A'
if dAr < dxr,
   answer = [answer; NaN*ones(dxr-dAr,size(answer,2))];
   %answer(:,index) = x(:,1);
   answer(:,index) = x;
end
%%%%%%END PADDING SECTION%%%%%%

%%%%%%DECIDE OUTPUT METHOD%%%%%%
%get input arguments name
ARGIN = inputname(1);
%if no output argument, ouput to A is available
if (nargout == 0)
   %if ARG is a variable
   if ~(isempty(ARGIN))
      assignin('caller', ARGIN, answer);
      return;
   end
end

%default action if either there is an ouput argument
%or if input is not a variable
output = answer;
%%%%%%END DECIDE OUTPUT METHOD%%%%%% 
