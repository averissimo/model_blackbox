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
            F = Xsim;
        else
            F = Xsim(end);
        end
    end
end

