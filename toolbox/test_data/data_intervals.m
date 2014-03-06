function [ output_best, output_index, output_results, output_sum_results] = data_intervals( xdata, ydata, index, print_flag )
%DATA_INTERVALS Summary of this function goes here
%   Detailed explanation goes here
    
    % creates internal dataset
    data = dataset( xdata, ydata, index );
    
    % gets unique indexes to iterate over them
    indexes = transpose(unique(data.index));
    
    % initializes the cell with outputs
    output_index       = [];
    output_results     = cell(length( indexes ),1 );
    output_sum_results = cell(length( indexes ),1 );
    output_best = struct('ids', [], 'params', {}, 'residuals', [], 'intervals', []);
    
    count   = 1; % count over the iteration
    for index = indexes

        % reduce the dataset to only this replicate
        data_reduced = data( data.index == index, 1:2);
        % get from dataest
        xdata = transpose( data_reduced.xdata );
        % ydata = transpose( data_reduced.ydata ); % not necessary

        %% define model
        model.model = @gompertza;
        model.pnames = {'A','lambda','miu','N'};
        model.ub = [20, 20, 3    ,   1];
        model.lb = [0  ,  0, 0.001, -15];

        %% create 3 sample intervals to test
        intervals = generate_intervals(xdata', 1);

        %% create 3 sample intervals to test
        %intervals = cell(1);
        %intervals{1} = [0, Inf ];
        %intervals{2} = [0, 4, Inf ];
        %intervals{3} = [0, 6, Inf ];

        %% call the estimation
        [best_t, result, sum_result] = estimate_intervals(data_reduced, ...
            model.pnames, intervals, 2, ...
            model.lb, model.ub, model.model, ...
            print_flag);
        
        % set outputs
        output_index              = cat(1,output_index,index);
        output_results{count}     = result;
        % from best_t
        
        output_best(1).ids           = cat(1, output_best.ids, best_t.id);
        output_best(1).params{count} = best_t.params;
        output_best(1).residuals     = cat(1, output_best.residuals, best_t.residual);
        output_best(1).intervals     = cat(1, output_best.intervals, best_t.interval);
        %
        output_sum_results{count} = sum_result;
        count = count + 1; % increment count
    end
end

