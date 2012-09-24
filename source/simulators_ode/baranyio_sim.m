function [ output ] = baranyio_sim( test_data , draw_plot )
%GOMPERTZA_SIM Summary of this function goes here
%   Detailed explanation goes here
    if nargin > 0 && test_data
        s = 'h0=20.0&m=2.553767&mu=0.846645&v=0.715549&y0=0.001689&ymax=15.229774&start=11.25&end=33.513333337&minor_step=0.866667';
        input = qs2struct(s);
    else
        input = qs2struct(getenv('QUERY_STRING'));    
    end
    
    try
        %
        params(1) = str2double( input.h0 );
        params(2) = str2double( input.m );
        params(3) = str2double( input.mu );
        params(4) = str2double( input.v );
        params(5) = str2double( input.y0 );
        params(6) = str2double( input.ymax );
        
        [TimeEnd, t_start, ~, resolution] = time_step(input);
        %
        model = @baranyio;
        
        values = model(params , TimeEnd);
        
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

