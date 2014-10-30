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
%
    %% get inputs
    % input paramters are in the environment variable "QUERY_STRING"
    if nargin > 0 && exist('test_data','var')
        if test_data == 1
          s = test_query('estimator','logistics');
        else
          s = test_data;
        end
        input = qs2struct(s);
    else
        input = qs2struct(getenv('QUERY_STRING'));
    end
    
    %% define model
    model = @logisticsa; % << change
    flag = 0;
    if nargin > 1 && draw_plot
        flag = 1;
    end
    debug_flag = 0;
    if nargin > 2 && debug
        debug_flag = 1;
    end
    %% Convert Y axis to ln(x)/ln(X0)
    % extract time and values
    % convert values
    % write back to input form
    [time,values_aux] = extract_time_values(input);
    values = values_aux - values_aux(1); % ln(x/x0) = ln(x)-ln(x0)
    time_s = '';
    values_s = '';
    for i = 1:(length(values)-1)
        time_s   = strcat( time_s,   sprintf('%f,', time(i)) );
        values_s = strcat( values_s, sprintf('%f,', values(i)) );
    end
    time_s   = strcat( '[', time_s,   sprintf('%f', time(length(values))),   ']' );
    values_s = strcat( '[', values_s, sprintf('%f', values(length(values))), ']' );
    input.time   = time_s;
    input.values = values_s;
    %
    
    %% Options for estimation
    % options retrieved from build estimation
    %% perform parameter estimation
    [output,output_string] = analytical_estimator(input, model, struct, flag, debug_flag);
    
    if output == 0
        output_string = strrep( output_string, '}', ',');
        %output_string(length(output_string)) = ',';
        output_string = strcat( output_string, sprintf('\n\t"N_0": %.14f,\n', values_aux(1)));
        output_string = strcat( output_string, sprintf('\t"t_0": %.14f\n', time(1)));
        output_string = strcat( output_string, '}');
    end
end