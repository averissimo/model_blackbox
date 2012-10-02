function output = testo_est(test_data, draw_plot, debug)
%
    %% get inputs
    % input paramters are in the environment variable "QUERY_STRING"
    if nargin > 0 && test_data
        s = 'param_names=[a,b]&param_top=[5.0,5.0]&param_bottom=[-5.0,0.0]&time=[0,1,2,3,4,5]&values=[0,1.1,4.2,8.2,16.1,25.2]';
        input = qs2struct(s);
    else
        input = qs2struct(getenv('QUERY_STRING'));    
    end
    
    %% define model
    model = @testo;
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



