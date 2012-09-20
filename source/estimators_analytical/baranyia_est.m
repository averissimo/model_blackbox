function output = baranyia_est(test_data, draw_plot, debug)
%
    %% get inputs
    % input paramters are in the environment variable "QUERY_STRING"
    if nargin > 0 && test_data
        s = 'time=[0.0,60.0,120.0,180.0,210.0,250.0,270.0,315.0,345.0,375.0,405.0,425.0]&values=[0.102,0.242,0.717,1.52,1.798,2.114,2.666,3.156,3.964,4.048,4.362,4.646]&param_names=[h0,m,mu,v,y0,ymax]&param_top=[5,5,20,5,5,10]&param_bottom=[-5,0,0,0,-5,0]';
        s = 'time=%5B0.0%2C60.0%2C120.0%2C180.0%2C210.0%2C250.0%2C270.0%2C315.0%2C345.0%2C375.0%2C405.0%2C425.0%5D&values=%5B0.102%2C0.242%2C0.717%2C1.52%2C1.798%2C2.114%2C2.666%2C3.156%2C3.964%2C4.048%2C4.362%2C4.646%5D&param_names=%5Bh0%2Cm%2Cmu%2Cv%2Cy0%2Cymax%5D&param_top=%5B5%2C5%2C20%2C5%2C5%2C10%5D&param_bottom=%5B-5%2C0%2C0%2C0%2C-5%2C0%5D';
        s = 'time=%5B0.0%2C60.0%2C120.0%2C180.0%2C210.0%2C250.0%2C270.0%2C315.0%2C345.0%2C375.0%2C405.0%2C425.0%2C1355.0%5D&values=%5B-2.282782465697866%2C-1.4188175528254507%2C-0.33267943838251673%2C0.41871033485818504%2C0.5866749360494286%2C0.7485818874480459%2C0.9805792217565169%2C1.1493054029836278%2C1.3772536164677416%2C1.3982229319851645%2C1.4729306677794374%2C1.5360066343482173%2C1.3802762887943276%5D&param_names=%5Bh0%2Cm%2Cmu%2Cv%2Cy0%2Cymax%5D&param_top=%5B10.0%2C1.0%2C1.0%2C0.025635%2C5.0%2C10.0%5D&param_bottom=%5B-5.0%2C1.0%2C0.0%2C0.025635%2C-5.0%2C0.0%5D';
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
    options.TolFun = 1e-7; % becomes too slow with default value
    options.TolX = 1e-7; % becomes too slow with default value
    %% perform parameter estimation
    output = analytical_estimator(input, model, options, flag, debug_flag);

end



