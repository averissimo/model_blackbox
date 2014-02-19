% type could be:
%  - 'simulator'
%  - 'estimator'
% name should be defined in test_query.m
function [ output_args ] = get_inputs( nargs, test_data, type, name )
    %
    %% get inputs
    % input paramters are in the environment variable "QUERY_STRING"
    if nargs > 0 && exist( 'test_data', 'var' )
        if test_data == 1
          s = test_query( type, name);
        elseif test_data == 0
          s = getenv('QUERY_STRING');
        else      
          s = test_data;
        end
        output_args = qs2struct(s);
    else
        output_args = qs2struct(getenv('QUERY_STRING'));
    end

end

