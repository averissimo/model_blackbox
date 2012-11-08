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

function output = monomero_est(test_data, draw_plot, debug)
%
    %% get inputs
    % input paramters are in the environment variable "QUERY_STRING"
    if nargin > 0 && test_data
        s = 'param_names=[fr,k11,M0,n]&param_top=[0.0861,2,1.1,2]&param_bottom=[0.086,0.1,1,0.1]&time=[0,1,3,6,17,24,48,64,90]&values=[1,0.899,0.619,0.623,0.489,0.299,0.268,0.267,0.289]';
        s = 'param_names=[fr,k11,M0,n]&param_top=[0.086,2.0,1.0,1.0]&param_bottom=[0.086,0.0,1.0,0.0]&time=[0.0,0.0,0.0,0.0,1.0,1.0,1.0,1.0,3.0,3.0,3.0,6.0,6.0,6.0,6.0,6.0,17.0,17.0,17.0,17.0,17.0,24.0,24.0,24.0,24.0,48.0,48.0,48.0,64.0,64.0,64.0,90.0,90.0,90.0]&values=[0.96,0.95,0.91,0.95,0.73,0.8,0.67,0.75,0.56,0.6,0.53,0.6,0.62,0.63,0.6,0.51,0.46,0.51,0.51,0.4,0.49,0.24,0.36,0.29,0.26,0.24,0.3,0.28,0.24,0.29,0.24,0.24,0.33,0.27]'
        input = qs2struct(s);
    else
        input = qs2struct(getenv('QUERY_STRING'));
    end

    %% define model
    model = @monomero;
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
    options.TolFun = 1e-7; % becomes too slow with default value
    options.TolX = 1e-7; % becomes too slow with default value
    %% perform parameter estimation
    output = analytical_estimator(input, model, options, flag, debug_flag);

end
