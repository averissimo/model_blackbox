function output = baranyia_est(test_data, draw_plot, debug)
%
    %% get inputs
    % input paramters are in the environment variable "QUERY_STRING"
    if nargin > 0 && test_data
        s = 'param_names=[h0,m,mu,v,y0,ymax]&param_top=[20.0,5.0,3.0,5.0,5.0,20.0]&param_bottom=[-5.0,-5.0,0.0,-5.0,-5.0,0.0]&time=[11.25,12.3,13.65,16.11666667,18.1,21.08333333,22.41666667,23.48333333,25.05,26.2,27.06666667,28.16666667,29.31666667,30.46666667]&values=[0.021,0.021,0.021,0.024,0.026,0.039,0.058,0.089,0.182,0.33,0.51,0.832,0.98,0.96]';
        s = 'param_names=[h0,m,mu,v,y0,ymax]&param_top=[5.0,5.0,3.0,10.0,5.0,10.0]&param_bottom=[-5.0,0.0,0.0,0.0,-5.0,0.0]&time=[0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0,25.6];[0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0,25.6];[0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0,24.0]&values=[-2.703062659591171,-1.851509473633829,-0.9263410677276565,-0.038740828316430595,0.6032224730319583,0.6911451778892722,0.7090205297162355,0.6688544879909007,0.6097655716208943];[-2.659260036932778,-1.973281345851445,-0.9063404010209869,-0.006018072325563021,0.6333971761541712,0.714908672341458,0.7419373447293773,0.6523251860396901,0.6585557357903262];[-2.8134107167600364,-1.410587053688935,-0.6386589952758756,0.2468600779315258,0.7848143690857692,0.7829878845597349,0.7011153502091222,0.7323678937132266,0.6668032052203433]';
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
