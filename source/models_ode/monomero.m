function F = monomero( params,t )
%BARANYIO Summary of this function goes here
%   Detailed explanation goes here

    % Extract each parameter from the model
    %  one of them must be the initial value for t = 0 / t = start
    fr   = params(1);
    k11  = params(2);
    M0   = params(3);
    n    = params(4);

   function dxdt = ode(t,x,params_)
        fr_  = params_(1);
        k11_ = params_(2);
        n_   = params_(3);

        dxdt = -2 .* fr_ .* fr_ .* k11_ .* ( n_ / 2 ) .* x .* x;
    end

    if isvector(t)
        tsim = t;
    else
        tsim = timeStep(t);
    end
    if length(tsim) == 1
        F = M0;
    else
        % ODE15s solver
        try
            initial_condition = M0; % change initial condition
            f_parameters = [fr,k11,n]; % change parameters (might not include initial condition if it is not parameter for equation
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
