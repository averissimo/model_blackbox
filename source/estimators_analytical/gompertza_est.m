function output = gompertza_est(test_data, draw_plot)
%
    %% get inputs
    % input paramters are in the environment variable "QUERY_STRING"
    if nargin > 0 && test_data
        s = 'time=[0.0,60.0,120.0,180.0,210.0,250.0,270.0,315.0,345.0,375.0,405.0,425.0]&values=[0.102,0.242,0.717,1.52,1.798,2.114,2.666,3.156,3.964,4.048,4.362,4.646]&estimation={"states":[{"name":"miu","bottom":0.0,"top":3.0},{"name":"lambda","bottom":-5.0,"top":120.0},{"name":"A","bottom":0.1,"top":10.0}]}';
        %,{"name":"N","bottom":-5.0,"top":5.0}
        s = 'time=[0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0]&values=[0.067,0.157,0.396,0.962,1.828,1.996,2.032,1.952]&estimation=%7B%22states%22:[%7B%22name%22:%22miu%22,%22bottom%22:0.0,%22top%22:3.0%7D,%7B%22name%22:%22lambda%22,%22bottom%22:-5.0,%22top%22:5.0%7D,%7B%22name%22:%22A%22,%22bottom%22:0.1,%22top%22:10.0%7D,{"name":"N","bottom":-5.0,"top":5.0}]%7D';
        s = 'time=[0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0]&values=[0.067,0.157,0.396,0.962,1.828,1.996,2.032,1.952]&estimation=%7B%22states%22:[%7B%22name%22:%22miu%22,%22bottom%22:0.0,%22top%22:3.0%7D,%7B%22name%22:%22lambda%22,%22bottom%22:-5.0,%22top%22:5.0%7D,%7B%22name%22:%22A%22,%22bottom%22:1.0e-05,%22top%22:10.0%7D,%7B%22name%22:%22N%22,%22bottom%22:0.1,%22top%22:10.0%7D]%7D';
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



