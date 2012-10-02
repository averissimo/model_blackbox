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


