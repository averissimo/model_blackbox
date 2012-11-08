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

function F = baranyio( params,t )
%BARANYIO Summary of this function goes here
%   Detailed explanation goes here

    h0   = params(1);
    m    = params(2);
    mu   = params(3);
    v    = params(4);
    y0   = params(5);
    ymax = params(6);

    function dxdt = ode(t,x,params)
        h0_   = params(1);
        m_    = params(2);
        mu_   = params(3);
        v_    = params(4);
        y0_   = params(5);
        ymax_ = params(6);

        dxdt = mu_ + (-exp(-t *v_) *v_ +   exp(-h0_ - t *v_) *v_)/((exp(-h0_) + exp(-t *v_) - exp(-h0_ - t *v_)) *mu_) - ( exp(m_ *mu_* t - m_* (-y0_ + ymax_) + log(exp(-h0_) + exp(-t *v_) - exp(-h0_ - t *v_))/ mu_) * (m_* mu_ + (-exp(-t *v_) *v_ + exp(-h0_ - t *v_)* v_)/((exp(-h0_) + exp(-t* v_) - exp(-h0_ - t* v_))* mu_)))/((1 + exp(-m_ * (-y0_ + ymax_)) * (-1 + exp( m_ *mu_ *t + log(exp(-h0_) + exp(-t *v_) - exp(-h0_ - t *v_))/mu_))) * m_);
    end

    if isvector(t)
        tsim = t;
    else
        tsim = time_step(t);
    end

    if length(tsim) == 1
        F = y0;
    else
        initial_condition = y0; % change initial condition
        f_parameters = [h0,m,mu,v,y0,ymax]; % change parameters (might not include initial condition if it is not parameter for equation
        [null,Xsim] = ode45(@ode, tsim , initial_condition,odeset,f_parameters);
        if isvector(t)
            F = Xsim';
        else
            F = Xsim(end);
        end
    end
end
