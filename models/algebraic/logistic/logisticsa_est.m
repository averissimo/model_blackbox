% Model Blackbox
% Copyright (C) 2014  afsverissimo@gmail.com
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

function [output_string,output] = logisticsa_est(test_data, draw_plot, debug)
    %% get input values
    % if test_data == 0 or not defined, then it gets input
    %  from the environment variable "QUERY_STRING", which is used in cgi
    %  script.
    % Otherwise, it should get from test_query or from the argument itself
    if ~exist('test_data','var'), test_data = 0; end
    input = get_inputs( nargin, test_data, 'estimator', 'logisticsa');    %
    
    %% define model
    model = @logisticsa; % << change
    flag = 0;       if nargin > 1 && draw_plot, flag = 1;       end
    debug_flag = 0; if nargin > 2 && debug,     debug_flag = 1; end
    %% Convert Y axis to ln(x)/ln(X0)
    [input, y_0, x_0] = convert_zwietering(input);
    
    %% Options for estimation
    % options retrieved from build estimation
    %% perform parameter estimation
    [output,output_string] = analytical_estimator(input, model, struct, flag, debug_flag);
    
    % adds x_0 and y_0 to output variables
    output_string = add_zwietering(output, output_string, y_0, x_0);
    
    if ~exist('OCTAVE_VERSION', 'builtin')
        fprintf(1, output_string);
    end
end
