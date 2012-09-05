function output = gompertza_est(test_data, draw_plot)
%
    %% get inputs
    % input paramters are in the environment variable "QUERY_STRING"
    if nargin > 0 && test_data
        %input = 'time=[0.0,1.167,2.0,3.167,4.083,5.333,6.333,7.25,8.25,9.0,9.917,11.0,11.833]&values=[0.052,0.074,0.104,0.155,0.205,0.283,0.38,0.447,0.618,0.715,0.792,0.923,0.953]&estimation=%7B"states":[%7B"name":"A","bottom": 0.3,"top":15%7C,%7B"name":"miu","bottom":0,"top":2%7C,%7B"name":"lambda","bottom":0,"top":4%7C],"initial":[%7B"name":"N","bottom":0,"top":1%7C,%7B"name":"t","bottom":0,"top":100%7C]%7C';
        %input = 'time=[0,1.167,2,3.167,4.083,5.333,6.333,7.25,8.25,9,9.917,11,11.833,26.75];[0,1.167,2,3.167,4.083,5.333,6.333,7.25,8.25,9,9.917,11,11.833,26.75]&values=[1.052,1.074,1.104,1.155,1.205,1.283,1.38,1.447,1.618,1.715,1.792,1.923,1.953,1.873];[0.052,0.074,0.104,0.155,0.205,0.283,0.38,0.447,0.618,0.715,0.792,0.923,0.953,0.873]&estimation=%7B"states":[%7B"name":"A","bottom":0.3,"top":30.0%7D,%7B"name":"lambda","bottom":-2.0,"top":5.0%7D,%7B"name":"miu","bottom":0.0,"top":3.0%7D],"initial":[%7B"name":"N","bottom":0.0001,"top":2.01%7D,%7B"name":"t","bottom":0,"top":100%7D]%7D';
        input = qs2struct('time=[0.0,60.0,120.0,180.0,210.0,250.0,270.0,315.0,345.0,375.0,405.0,425.0]&values=[0.102,0.242,0.717,1.52,1.798,2.114,2.666,3.156,3.964,4.048,4.362,4.646]&estimation=%7B%22states%22:[%7B%22name%22:%22A%22,%22bottom%22:0.3,%22top%22:10.0%7D,%7B%22name%22:%22lambda%22,%22bottom%22:-2.0,%22top%22:105.0%7D,%7B%22name%22:%22miu%22,%22bottom%22:0.0,%22top%22:1.0%7D],%22initial%22:[%7B%22name%22:%22N%22,%22bottom%22:0.0001,%22top%22:30.0%7D,%7B%22name%22:%22t%22,%22bottom%22:0,%22top%22:467.50000000000006%7D]%7D');
    else
        input = qs2struct(getenv('QUERY_STRING'));    
    end
    
    %% define model
    model = @gompertza;
    flag = 0;
    if nargin > 1 && draw_plot
        flag = 1;
    end
    %% perform parameter estimation
    output = analytical_estimator(input, model, flag);

end



