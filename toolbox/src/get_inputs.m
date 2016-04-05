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
    s = '';
    ffid = fopen('/tmp/2veri_test.txt','a');
    if nargs > 0 && exist( 'test_data', 'var' )
	fwrite(ffid, 'nargs > 0');
    	fwrite(ffid, 10);
        if test_data == 1
	  fwrite(ffid, '1');
    	  fwrite(ffid, 10);
          s = test_query( type, name);
        elseif test_data == 0
	  fwrite(ffid, '2');
    	  fwrite(ffid, 10);
	  s = getenv('QUERY_STRING');
	else
          fwrite(ffid, '5');
          fwrite(ffid, 10);
	  s = test_data;
	end
	output_args = qs2struct(s);
    else
	fwrite(ffid, '6');
        fwrite(ffid, 10);
        %% check if it is a POST or GET method
        method = getenv('REQUEST_METHOD');
        if length(getenv('QUERY_STRING')) <= 0 && strcmp(method,'POST')
      	  fwrite(ffid, '3');
          fwrite(ffid, 10);
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
	  output_args = qs2struct(post);
        else
          output_args = qs2struct(getenv('QUERY_STRING'));
        end
    end

    output_args = escape_uri( output_args );
end
