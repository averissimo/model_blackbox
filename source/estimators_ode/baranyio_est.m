function output = baranyia_est(test_data, draw_plot, debug)
%
    %% get inputs
    % input paramters are in the environment variable "QUERY_STRING"
    if nargin > 0 && test_data
        s = 'param_names=[h0,m,mu,v,y0,ymax]&param_top=[20.0,5.0,3.0,5.0,5.0,20.0]&param_bottom=[-5.0,-5.0,0.0,-5.0,-5.0,0.0]&time=[11.25,12.3,13.65,16.11666667,18.1,21.08333333,22.41666667,23.48333333,25.05,26.2,27.06666667,28.16666667,29.31666667,30.46666667]&values=[0.021,0.021,0.021,0.024,0.026,0.039,0.058,0.089,0.182,0.33,0.51,0.832,0.98,0.96]';
        input = qs2struct(s);
    else
        input = qs2struct(getenv('QUERY_STRING'));    
    end
    
    %% define model
    model = @baranyio;
    flag = 0;
    if nargin > 1 && draw_plot
        flag = 1;
    end
    debug_flag = 0;
    if nargin > 2 && debug
        debug_flag = 1; 
    end
    %% Options for estimation
    % options retrieved from build estimation
    options.TolFun = 1e-7; % becomes too slow with default value
    options.TolX = 1e-7; % becomes too slow with default value
    %% perform parameter estimation
    output = analytical_estimator(input, model, options, flag, debug_flag);

end



