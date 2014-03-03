function [ result, sum_result ] = estimate_intervals( input_data, pnames, intervals, sliding_param, lb, ub, model, print_flag )
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
for i = 1:length(intervals)
    interval = intervals{i};
    %clf(h); % not needed as each figure call generates a new window
    h = figure;
    result_t = cat(1, result_t, ...
        estimate_interval(input_data, pnames, interval, sliding_param, lb, ub, model));
    Id = cat(1, Id, repeat(i, length(interval) - 1));
    if exist('print_flag','var') && print_flag == 1
        print(h, PRINT_OPTION, sprintf('/%s/%s-%d.%s', log_dir, i, PRINT_EXT));    
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
   new_ids = cat( 1, new_ids, i);
   sums = cat(1, sums, sum(result.SumResiduals(result.Id == i)));
end
sum_result = dataset(new_ids, sums);
sum_result.Properties.VarNames = {'Id','SumResiduals'};
end

