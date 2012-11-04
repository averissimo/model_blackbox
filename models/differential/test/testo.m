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

function F = testo( params, t )
%BARANYIO Summary of this function goes here
%   Detailed explanation goes here

    a = params(1);
    b = params(2);

    function dxdt = ode(t, x, params_)
    %        a_   = params(1);
        b_   = params_(1);

        dxdt = 2.*b_.*t;
    end

    if isvector(t)
        tsim = t;
    else
        tsim = time_step(t);
    end

    if length(tsim) == 1
        F = a;
    else
        initial_condition = a; % change initial condition
        f_parameters = [b]; % change parameters (might not include initial condition if it is not parameter for equation
        [null,Xsim] = ode45(@ode, tsim , initial_condition,odeset,f_parameters);

        if isvector(t)
            F = Xsim';
        else
            F = Xsim(end);
        end
    end
end
