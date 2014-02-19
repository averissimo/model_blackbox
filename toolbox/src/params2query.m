function [ output_args ] = params2query( params_name, lb, lb_name, ub, ub_name, t, t_name, v, v_name)
%PARAMS2QUERY Summary of this function goes here
%   Detailed explanation goes here

    output_args = strcat( params_name, '&', array2query(lb, lb_name), '&', array2query( ub, ub_name), '&', array2query( t, t_name), '&', array2query( v, v_name));

    function str = array2query( array, name ) 
          str = strcat( name, '=[');
          count = length(array);
          for i = array
             count = count - 1;
             str = strcat(str, num2str(i));
             if not(count == 0)
                 str = strcat( str, ',' );
             end
          end
          str = strcat(str,']');

    end
end

