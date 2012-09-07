function [ output ] = baranyia_sim( test_data , draw_plot )
%GOMPERTZA_SIM Summary of this function goes here
%   Detailed explanation goes here
    if nargin > 0 && test_data
        s = 'm=5.000000,&y0=0.001381,&h0=2&ymax=5.000000,&mu=0.246028,&v=0.325587,&N=0.120706&end=20';
        s = 'm=16.724087,&y0=0.643485,&h0=2.905646&ymax=7.787065,&mu=1.080329,&v=1.216351,&N=&end=20';
        %s = 'h0=0.733564&m=0.534439&mu=2.570644&N=0.042879&v=4.99849&y0=-4.858&ymax=0.000875&end=25';
        s = 'h0=3.713722&m=5.162075&mu=1.201054&v=1.407028&y0=0.067029&ymax=4.476695&end=7.700000000000001';
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
        TimeEnd = timeStep( str2double( input.end ) );
        %
        model = @baranyia;
        
        values = model(params , TimeEnd);
        output = [ transpose(TimeEnd) transpose(values) ];
        
        if nargin > 1 && draw_plot
            plot(TimeEnd,values);
        end
        printJson(output);
    catch err
        msg = sprintf('{ "error": "%s" }\n',err.message);
        printHeader(length(msg));
        fprintf(1,'%s',msg);    
    end

end

