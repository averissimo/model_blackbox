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
          s = test_query( type, name);
        elseif test_data == 0
          %% check if it is a POST or GET method
          method = getenv('REQUEST_METHOD');
          if length(getenv('QUERY_STRING')) <= 0 && strcmp(method,'POST')
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
              s = post;
              fclose(fid);
          else
              s = getenv('QUERY_STRING');
          end
        else
          s = test_data;
        end
        output_args = qs2struct(s);
    else
        output_args = qs2struct(getenv('QUERY_STRING'));
    end

    output_args = escape_uri( output_args );

    ffid = fopen('/tmp/veri_test.txt','a');
    fwrite(ffid, '-------------------------');
    fwrite(ffid, 10);
    fwrite(ffid, evalc(['disp(output_args)']));
    fwrite(ffid, 10);
    fwrite(ffid, output_args.querystring);
    fwrite(ffid, 10);
    fwrite(ffid, output_args.time);
    fwrite(ffid, 10);
    fwrite(ffid, output_args.values);
    fwrite(ffid, 10);
    fclose(ffid);

end
