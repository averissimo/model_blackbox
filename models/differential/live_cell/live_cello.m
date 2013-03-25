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

function [ F ] = live_cell_fraction_modelo( params,t )
%live_cell_fraction_modelo Summary of this function goes here
    % Extract each parameter from the model
    %  one of them must be the initial value for t = 0 / t = start
    alpha_  = params(1);
    delta_  = params(2);
    lambda_  = params(3);
    r0_  = params(4);
    
   function dxdt = ode(t,x,params_)
        alpha  = params(1);
        delta  = params(2);
        lambda  = params(3);

        dxdt = x / 3 * ( ( alpha + delta ) * 3 * lambda / ( 3 * lambda + x ) - delta );
    end

    if isvector(t)
        tsim = t;
    else
        tsim = timeStep(t);
    end
    if length(tsim) == 1
        F = r0_;
    else
        % ODE15s solver
        try
            initial_condition = r0_; % << change initial condition
            f_parameters = [alpha_,delta_,lambda_]; % << change parameters (might not include initial condition if it is not parameter for equation
            [null, Xsim] = ode15s(@ode, tsim' , initial_condition, odeset, f_parameters);
        catch
            err = lasterror();
            % with stiffer OD45 solver
            [null, Xsim] = ode45(@ode, tsim , initial_condition, odeset, f_parameters);
        end
        if isvector(t)
            F = Xsim';
        else
            F = Xsim(end);
        end
    end
end
