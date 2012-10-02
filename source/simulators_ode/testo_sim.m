function [ output ] = testo_sim( test_data , draw_plot )
%GOMPERTZA_SIM Summary of this function goes here
%   Detailed explanation goes here
    if nargin > 0 && test_data
        s = 'a=0&b=1&start=11.25&end=30&minor_step=0.866667';
        input = qs2struct(s);
    else
        input = qs2struct(getenv('QUERY_STRING'));    
    end
    
    try
        %
        params(1) = str2double( input.a );
        params(2) = str2double( input.b );
        
        [TimeEnd, t_start, null, resolution] = time_step(input);
        %
        model = @testo;
        
        values = model(TimeEnd,params);
        
        output = [ transpose(TimeEnd) values ];
        
        if nargin > 1 && draw_plot
            scatter(TimeEnd,values);
        end
        printJson(output);
    catch err
        msg = sprintf('{ "error": "%s" }\n',err.message);
        printHeader(length(msg));
        fprintf(1,'%s',msg);    
    end

end

