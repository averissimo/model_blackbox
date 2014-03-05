function [ output ] = estimate_interval( input_data, pnames, interval, sliding_param, lb, ub, model )
%ESTIMATE_INTERVALS Summary of this function goes here
%   Detailed explanation goes here

    % f(x) for the previous interval, NaN if the first time
    last = NaN;

    % allocate result cell, with:
    %  - 1st column: start of interval
    %  - 2nd column: end of interval
    %  - 3rd column: estimated parameters
    %  - 4th column: sum of residuals
    result = cell( length(interval)-1, 4 );
    index = 1;

    % sort the interval
    interval = unique(sort(interval));
    % add Inf to end if the upper interval is not contemplated
    if interval(end) < max(input_data.xdata), interval = cat( 2, inteval, Inf ); end
    % add -Inf to start if the bottom interval is not contemplated
    if interval(1) > min(input_data.xdata), interval = cat( 2, -Inf, interval ); end
       
    % iterate on the interval
    for j = 1:(length(interval)-1)
        
        % create temporary variables that represent start and finish of
        % interval
        start_t = interval(j);
        end_t   = interval(j + 1);

        % create xdata and ydata that represent current sub-interval
        data_t = input_data( input_data.xdata >= start_t & input_data.xdata <= end_t,: );
        xdata  = transpose( data_t.xdata );
        ydata  = transpose( data_t.ydata );
        
        % sliding param
        if sliding_param > 0 && ~isnan(last)
           lb(sliding_param) = lb(sliding_param) - (max(xdata) - start_t) * 1.5; % slide by 150% just in case
        end

        %% create string for call and convert to input
        s = params2query( pnames, lb, 'param_bottom', ub, 'param_top', xdata, 'time', ydata, 'values' );
        if iscell(s), s = s{1}; end
        input = get_inputs(1,s);

        %% debug information and plot
        % draw plot of the estimation? (1: yes, 0: no)
        draw_flag = 1;
        % show debug info? (1: yes, 0: no)
        debug_flag = 0;

        %% perform parameter estimation
        [output,output_string,params,residuals] = analytical_estimator(input, model, struct, draw_flag, debug_flag);
        result{index,1} = start_t;   % minimum timepoint
        result{index,2} = end_t;     % maximum timepoint
        result{index,3} = residuals; % residuals from fitting
        result{index,4} = params;    % parameters from fitting
        
        % increment index
        index = index + 1;
        last = model(params, max(xdata));
    end
    t = get( get(gca, 'Title'), 'String');
    title( strcat( t, ' with intervals: [', num2str(interval), ']') );

    Start        = cat(1,result{:,1});
    End          = cat(1,result{:,2});
    SumResiduals = cat(1,result{:,3});
    Params       = cat(1,result{:,4});
    output = dataset(Start,End, SumResiduals, Params);
end

