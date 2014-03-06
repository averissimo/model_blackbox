function [ best, result, sum_result ] = estimate_intervals( input_data, pnames, intervals, sliding_param, lb, ub, model, print_flag )
%ESTIMATE_INTERVALS Summary of this function goes here
%   Detailed explanation goes here
    PRINT_OPTION = '-dpng';
    PRINT_EXT    = 'png';

    % initialize result to an empty dataset and other variables
    result_t = dataset();
    Id = [];
    % create temporary dir with results
    if exist('print_flag','var') && print_flag == 1
        log_dir = sprintf('/tmp/model-blackbox/%s/%s', datestr(now,'yy-mm-dd'),datestr(now,'HH-MM'));
        mkdir(log_dir);
    end

    Intervals = {};
    count = 1;
    for i = 1:length(intervals)
        interval = intervals{i};
        h = figure;
        try
            result_t = cat(1, result_t, ...
                estimate_single_interval(input_data, pnames, interval, ...
                                  sliding_param, lb, ub, model));
            Id = cat(1, Id, repmat(i, length(interval) - 1, 1));
            if exist('print_flag','var') && print_flag == 1
                print(h, PRINT_OPTION, sprintf('/%s/%s-%d.%s', log_dir, i, PRINT_EXT));    
            end
            t = get( get(gca, 'Title'), 'String');
            title( strcat( t,' (id: ', num2str(i), ')') );
            Intervals{count} = interval; %#ok<*AGROW>
            count = count + 1;
        catch err
            close(h);
            fprintf(1,'error in interval!\n  message:\t%s\n', err.message);
            try
                fprintf(1,'  interval:\t%s\n', num2str(interval));
            catch
                disp(interval);
            end
        end
    end
    if exist('print_flag','var') && print_flag == 1
        fprintf(1,'plots of results are stored in %s\n', log_dir);
    end
    result = cat(2, dataset(Id), result_t);

    % iterate on all items with same id to get mse
    new_ids = [];
    sums    = [];
    for i = unique(result.Id)'
       new_ids  = cat( 1, new_ids, i);
       sums     = cat(1, sums, sum(result.SumResiduals(result.Id == i)));
    end
    sum_result = dataset(new_ids, sums, Intervals');
    sum_result.Properties.VarNames = {'Id','SumResiduals','Interval'};

    [best.residual,pos] = min(sums);
    best.id       = new_ids(pos);
    best.interval = Intervals(pos);  
    best.params   = result(result.Id==2,:);

end
