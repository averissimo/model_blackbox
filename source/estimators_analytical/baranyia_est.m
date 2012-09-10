function output = baranyia_est(test_data, draw_plot, debug)
%
    %% get inputs
    % input paramters are in the environment variable "QUERY_STRING"
    if nargin > 0 && test_data
        s = 'time=[0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0];[0.0,1.0,2.0,3.0,4.0,5.0];[0.0,1.0,2.1,3.0,4.1,5.1,6.0,7.0];[0.0,1.0,2.1,3.0,4.1,5.1,6.0,7.0];[0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0];[0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0,25.6];[0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.05];[0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.05,23.42];[0.0,1.317,2.0,2.983,3.983,4.917,6.0];[0.0,0.917,2.083,2.917,4.083,5.0,6.167,7.25]&values=[0.04,0.113,0.363,0.924,1.632,2.288,2.172,2.188];[0.06,0.244,0.528,1.28,2.192,2.188];[0.068,0.143,0.391,0.994,1.78,2.268,2.336,2.308];[0.055,0.116,0.27,0.6,1.348,2.04,2.292,2.272];[0.067,0.157,0.396,0.962,1.828,1.996,2.032,1.952];[0.07,0.139,0.404,0.994,1.884,2.044,2.1,1.92,1.932];[0.06,0.12,0.29,0.77,1.64,2.42,2.515,2.4];[0.06,0.13,0.34,0.91,1.81,2.03,2.535,2.47,2.5];[0.049,0.142,0.274,0.682,1.448,1.952,2.296];[0.052,0.091,0.288,0.63,1.437,2.07,2.352,2.22]&estimation=%7B"states":[%7B"name":"h0","bottom":-5.0,"top":5.0%7D,%7B"name":"m","bottom":-5.0,"top":5.0%7D,%7B"name":"mu","bottom":0.0,"top":3.0%7D,%7B"name":"v","bottom":-5.0,"top":5.0%7D,%7B"name":"y0","bottom":-5.0,"top":5.0%7D,%7B"name":"ymax","bottom":0.0,"top":10.0%7D],"initial":[%7B"name":"N","bottom":0.0,"top":0.0%7D,%7B"name":"t","bottom":0,"top":100%7D]%7D';
        s = 'time=[0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0]&values=[0.04,0.113,0.363,0.924,1.632,2.288,2.172,2.188]&estimation=%7B"states":[%7B"name":"h0","bottom":-5.0,"top":5.0%7D,%7B"name":"m","bottom":-5.0,"top":5.0%7D,%7B"name":"mu","bottom":0.0,"top":3.0%7D,%7B"name":"v","bottom":-5.0,"top":5.0%7D,%7B"name":"y0","bottom":-5.0,"top":5.0%7D,%7B"name":"ymax","bottom":0.0,"top":10.0%7D],"initial":[%7B"name":"N","bottom":0.0,"top":0.0%7D,%7B"name":"t","bottom":0,"top":100%7D]%7D';
        s = 'time=[0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0]&values=[0.067,0.157,0.396,0.962,1.828,1.996,2.032,1.952]&estimation=%7B%22states%22:[%7B%22name%22:%22h0%22,%22bottom%22:-5.0,%22top%22:5.0%7D,%7B%22name%22:%22m%22,%22bottom%22:-5.0,%22top%22:5.0%7D,%7B%22name%22:%22mu%22,%22bottom%22:0.0,%22top%22:3.0%7D,%7B%22name%22:%22v%22,%22bottom%22:-5.0,%22top%22:5.0%7D,%7B%22name%22:%22y0%22,%22bottom%22:-5.0,%22top%22:5.0%7D,%7B%22name%22:%22ymax%22,%22bottom%22:0.0,%22top%22:10.0%7D]%7D';
        s = 'time=[11.25,12.3,13.65,16.11666667,18.1,21.08333333,22.41666667,23.48333333,25.05,26.2,27.06666667,28.16666667,29.31666667]&values=[0.021,0.021,0.021,0.024,0.026,0.039,0.058,0.089,0.182,0.33,0.51,0.832,0.98]&estimation={"states":[{"name":"h0","bottom":-5.0,"top":100.0},{"name":"m","bottom":-5.0,"top":5.0},{"name":"mu","bottom":0.0,"top":3.0},{"name":"v","bottom":-5.0,"top":5.0},{"name":"y0","bottom":-5.0,"top":5.0},{"name":"ymax","bottom":0.1,"top":10.0}]}';
        s = 'time=[11.25,12.3,13.65,16.11666667,18.1,21.08333333,22.41666667,23.48333333,25.05,26.2,27.06666667,28.16666667,29.31666667]&values=[0.021,0.021,0.021,0.024,0.026,0.039,0.058,0.089,0.182,0.33,0.51,0.832,0.98]&estimation={"states":[{"name":"h0","bottom":-5.0,"top":100.0},{"name":"m","bottom":0.1,"top":5.0},{"name":"mu","bottom":0.0,"top":3.0},{"name":"v","bottom":-5.0,"top":5.0},{"name":"y0","bottom":-5.0,"top":5.0},{"name":"ymax","bottom":0.1,"top":10.0}]}';
        s = 'time=[0.0,1.0,2.0,3.0,4.0,5.0]&values=[0.06,0.244,0.528,1.28,2.192,2.188]&estimation=%7B%22states%22:[%7B%22name%22:%22h0%22,%22bottom%22:-5.0,%22top%22:5.0%7D,%7B%22name%22:%22m%22,%22bottom%22:-5.0,%22top%22:5.0%7D,%7B%22name%22:%22mu%22,%22bottom%22:0.0,%22top%22:3.0%7D,%7B%22name%22:%22v%22,%22bottom%22:-5.0,%22top%22:5.0%7D,%7B%22name%22:%22y0%22,%22bottom%22:-5.0,%22top%22:5.0%7D,%7B%22name%22:%22ymax%22,%22bottom%22:0.0,%22top%22:10.0%7D]%7D';
        input = qs2struct(s);
    else
        input = qs2struct(getenv('QUERY_STRING'));    
    end
    
    %% define model
    model = @baranyia;
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
    options.TolFun = 1e-8; % becomes too slow with default value
    options.TolX = 1e-8; % becomes too slow with default value
    %% perform parameter estimation
    output = analytical_estimator(input, model, options, flag, debug_flag);

end



