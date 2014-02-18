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

function [ string_output,output ] = reversible_hills_equationa_sim( test_data , draw_plot ) % << change
%GOMPERTZA_SIM Summary of this function goes here
%   Detailed explanation goes here
    if nargin > 0 && test_data
        if test_data == 1
          s = test_query('simulator','reversible hills equation');
        else
          s = test_data;
        end
        input = qs2struct(s);
    else
        input = qs2struct(getenv('QUERY_STRING'));
    end

    try
        %
        params(1) = str2double( input.KA );
        params(2) = str2double( input.KeqPK );
        params(3) = str2double( input.KI );
        params(4) = str2double( input.KmADP );
        params(5) = str2double( input.KmATP );
        params(6) = str2double( input.KmPEP );
        params(7) = str2double( input.KmPYR );
        params(8) = str2double( input.n );
        params(9) = str2double( input.s );
        params(10) = str2double( input.t );
        params(11) = str2double( input.vmax_PK );

        [TimeEnd, t_start, null, resolution] = time_step(input);
        %
        model = @reversible_hills_equationa; % << change

        values = model(params,TimeEnd);

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