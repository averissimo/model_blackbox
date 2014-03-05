function [ intervals ] = generate_intervals( input_data, num_intervals )
%GENERATE_INTERVALS Summary of this function goes here
%   Detailed explanation goes here

    % this works on the principle that data is ordered
    % (with many pop operations)
    input_data = sort( input_data );
    % start is always the first value
    start = input_data(1);
    sub_data = input_data(2:end);
    % first result is a full interval
    result = {[start, max(sub_data)]};
    
    % call first sub_intervals
    sub_intervals( sub_data, start, num_intervals)
    intervals = result;
    
    % print results
    DEBUG = 0;
    if DEBUG
        for i = 1:length(intervals)
            ary = intervals{i};
            for j = ary
                fprintf(1,'%d,',j);
            end
            fprintf(1,'\n');
        end
    end;
    
    function sub_intervals( sub_data, start, ...
            recursive_counts)
    
       % breaks if sub_data only has last value
       %  or recursive counts has passed its objective
       if length(sub_data) <= 1 || recursive_counts <=  0 , return; end % stop condition
       
       % pops value and adds to current start
       new_start = cat(2,start, sub_data(1));
       % pops value from data
       new_data = sub_data(2:end);
        
       % adds current start to result
       result_t = [new_start, max(sub_data)];
       result = cat(1,result, result_t);
       
       % next call in the same recursive count
       sub_intervals( new_data, start, recursive_counts);
       % call the next recursive count
       sub_intervals( new_data, new_start, recursive_counts - 1);
    end


end

