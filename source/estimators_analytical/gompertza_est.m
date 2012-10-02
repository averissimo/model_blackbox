function output = gompertza_est(test_data, draw_plot,debug)
%
    %% get inputs
    % input paramters are in the environment variable "QUERY_STRING"
    if nargin > 0 && test_data
        s = '';
        input = qs2struct( s );
    else
        input = qs2struct(getenv('QUERY_STRING'));    
    end
    
    %% define model
    model = @gompertza;
    flag = 0;
    if nargin > 1 && draw_plot
        flag = 1;
    end
    debug_flag = 0;
    if nargin > 2 && debug
        debug_flag = 1;
    end
    %% perform parameter estimation
    output = analytical_estimator(input, model, struct , flag, debug_flag);

end



