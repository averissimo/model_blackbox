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

function [ output, t_start, t_end resolution ] = time_step( input )
%TIMESTEP Summary of this function goes here
%   Detailed explanation goes here

    if isfield( input, 'start' )
        t_start = str2double( input.start );
    else
        t_start = 0;
    end

    if isfield( input, 'minor_step' )
        minor_step = str2double( input.minor_step );
    else
        minor_step = 0;
    end

    t_end = str2double( input.end );

    MAX_STEPS = 2500;

    if minor_step > 0 && minor_step * MAX_STEPS < t_end + t_start
        resolution = minor_step * 0.5;
    else
        resolution = ceil(t_end) / MAX_STEPS;
    end

    if t_end == t_start
        output = t_start;
    else
        output = t_start:resolution:ceil(t_end);
    end

    if t_start > 0
        output = [0:resolution:(t_start-resolution) output];
    end
end
