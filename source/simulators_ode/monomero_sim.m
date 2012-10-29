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

function [ output ] = monomero_sim( test_data , draw_plot )
%GOMPERTZA_SIM Summary of this function goes here
%   Detailed explanation goes here
    if nargin > 0 && test_data
        s = 'fr=0.12&k11=10&M0=1&n=1&start=0&end=30&minor_step=0.866667';
        input = qs2struct(s);
    else
        input = qs2struct(getenv('QUERY_STRING'));
    end

    try
        %
        params(1) = str2double( input.fr );
        params(2) = str2double( input.k11 );
        params(3) = str2double( input.M0 );
        params(4) = str2double( input.n );

        [TimeEnd, t_start, null, resolution] = time_step(input);
        %
        model = @monomero;

        values = model(params,TimeEnd);

        output = [ transpose(TimeEnd), transpose(values) ];

        if nargin > 1 && draw_plot
            scatter(TimeEnd,values);
        end
        printJson(output);
    catch
        err = lasterror();
        printHeader(0);
        print_error_json(err,1);
    end

end
