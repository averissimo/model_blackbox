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

function [ string_output,output ] = logisticsa_sim( test_data , draw_plot ) % << change
%GOMPERTZA_SIM Summary of this function goes here
%   Detailed explanation goes here
    if nargin > 0 && exist('test_data','var')
        if test_data == 1
          s = test_query('simulator','logistics');
        else
          s = test_data;
        end
        input = qs2struct(s);
    else
        input = qs2struct(getenv('QUERY_STRING'));
    end

    try
        %
        params(1) = str2double( input.A );
        params(2) = str2double( input.lambda );
        params(3) = str2double( input.miu );
        % gets N_0
        N_0 = str2double( input.N_0 );
        
        [TimeEnd, t_start, null, resolution] = time_step(input);
        %
        
        model = @logisticsa; % << change
        
        values = model(params,TimeEnd);
        values = values + N_0; % adds to reconvert

        output = [ transpose(TimeEnd), transpose(values) ];

        if nargin > 1 && draw_plot
            scatter(TimeEnd,values);
        end
        string_output = printJson(output);
    catch
        err = lasterror();
        msg = sprintf('{ "error": "%s" }\n',err.message);
        string_output = msg
	end

end