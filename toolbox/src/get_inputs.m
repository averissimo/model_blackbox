% type could be:
%  - 'simulator'
%  - 'estimator'
% name should be defined in test_query.m
% to run with custom test_data just call it:
%  get_inputs(1,'param_names=[...')
function [ output_args ] = get_inputs( nargs, test_data, type, name )
  %
  %% get inputs
  % input paramters are in the environment variable "QUERY_STRING"
  if nargs > 0 && exist( 'test_data', 'var' )
    if test_data == 1
      output_args = test_query( type, name);
    elseif test_data == 0
      output_args = retrieve_get_or_post(); 
    else
      output_args = test_data;
    end
    output_args = qs2struct(output_args);
  else
   output_args = retrieve_get_or_post(); 
  end
  %
  output_args = escape_uri( output_args );
  %
  function [ out ] = retrieve_get_or_post()
    % check if it is a POST or GET method
    method = getenv('REQUEST_METHOD');
    if length(getenv('QUERY_STRING')) <= 0 && strcmp(method,'POST')
      % POST methods have to read from standard input
      %  to obtain parameters.
      post = '';
      fid = fopen('/dev/fd/0');
      eof = 1;
      while eof == 1
        post_tmp = fgets(fid,3000);
        if post_tmp == -1
          eof = 0;
        else
          post = strcat(post,post_tmp);
        end
      end
      fclose(fid);
      out = qs2struct(post);
    else
      out = qs2struct(getenv('QUERY_STRING'));
    end
  end
 
end
