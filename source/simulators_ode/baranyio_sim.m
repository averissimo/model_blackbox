function [ output ] = baranyio_sim( test_data , draw_plot )
%GOMPERTZA_SIM Summary of this function goes here
%   Detailed explanation goes here
    if nargin > 0 && test_data
        s = 'm=16.724087,&y0=0.643485,&h0=2.905646&ymax=7.787065,&mu=1.080329,&v=1.216351,&N=&end=20';
        s = 'h0=-0.003403&m=-0.657574&mu=0.012902&v=17.718774&y0=0.29745&ymax=1.735577&end=467';
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

        if isfield( input, 'minor_step' )
            TimeEnd = timeStep( str2double( input.end ), str2double( input.minor_step ) );
        else
            TimeEnd = timeStep( str2double( input.end ) );
        end
        %
        model = @baranyio;
        
        values = model(params , TimeEnd);
        output = [ transpose(TimeEnd) transpose(values) ];
        
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

