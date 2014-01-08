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

function [output_string,output] = live_cello_est( test_data, draw_plot, debug )
%
    %% get inputs
    % input paramters are in the environment variable "QUERY_STRING"
    if nargin > 0 && test_data
        if test_data == 1
          s = test_query('estimator','live cell');
        else
          s = test_data;
        end
        input = qs2struct(s);
    else
        input = qs2struct(getenv('QUERY_STRING'));
    end

    %% define model
    model = @live_cello; % << change
    flag = 0;
    if nargin > 1 && draw_plot
        flag = 1;
    end
    debug_flag = 0;
    if nargin > 2 && debug
        debug_flag = 1;
    end
    %% Options for estimation
    % options retrieved from build estimation
    options.TolFun = 1e-6; % becomes too slow with default value
    options.TolX = 1e-6; % becomes too slow with default value
    %% perform parameter estimation
    [output,output_string] = analytical_estimator(input, model, options, flag, debug_flag);
    fprintf(1,printHeader(0));
    fprintf(1,output_string);
end
