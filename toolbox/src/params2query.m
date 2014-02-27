function [ output_args ] = params2query( params_name, lb, lb_name, ub, ub_name, t, t_name, v, v_name)
%PARAMS2QUERY Summary of this function goes here
%   Detailed explanation goes here
    
    if iscell(params_name)
        param_name_str = array2query( params_name, 'param_names');
    else
        param_name_str = param_name;
    end
    output_args = strcat( param_name_str, '&', ...
        array2query(lb, lb_name), '&', ...
        array2query( ub, ub_name), '&', ...
        array2query( t, t_name), '&', ...
        array2query( v, v_name));
    

    function str = array2query( array, name ) 
          str = strcat( name, '=[');
          count = length(array);
          for i = array
             count = count - 1;
             if iscell(i)
                str = strcat(str, i);
             else
                str = strcat(str, num2str( i ));
             end
             if not(count == 0)
                 str = strcat( str, ',' );
             end
          end
          str = strcat(str,']');

    end
end

