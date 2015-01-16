% Model Blackbox
% Copyright (C) 2013  afsverissimo@gmail.com
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

function [ string_output,output ] = live_cello_sim( test_data , draw_plot ) % << change
    %% get input values
    % if test_data == 0 or not defined, then it gets input
    %  from the environment variable "QUERY_STRING", which is used in cgi
    %  script.
    % Otherwise, it should get from test_query or from the argument itself
    if ~exist('test_data','var'), test_data = 0; end
    input = get_inputs( nargin, test_data, 'simulator', 'live cell');
    
    %%
    try
        %
        params(1) = str2double( input.alpha );
        params(2) = str2double( input.delta );
        params(3) = str2double( input.lambda );
        params(4) = str2double( input.r0 );

        [TimeEnd, t_start, null, resolution] = time_step(input);
        %
        model = @live_cello; % << change

        values = model(params,TimeEnd);

        output = [ transpose(TimeEnd), transpose(values) ];

        if nargin > 1 && draw_plot
            scatter(TimeEnd,values);
        end
        string_output = printJson(output);
    catch
        err = lasterror();
        msg = sprintf('{ "error": "%s" }\n',err.message);
        string_output = msg;
    end
    fprintf(1,printHeader(0));
    fprintf(1,string_output);
end