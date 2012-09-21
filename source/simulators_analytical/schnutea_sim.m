function [ output ] = schnutea_sim( test_data , draw_plot ) % << change
%GOMPERTZA_SIM Summary of this function goes here
%   Detailed explanation goes here
    if nargin > 0 && test_data
        input = qs2struct('a=1&b=0.5&lambda=0&miu=1&N=1.5&end=20');
    else
        input = qs2struct(getenv('QUERY_STRING'));    
    end
    
    try
        % change to reflect the parameters (sorted by alphabetic order)
        params(1) = str2double( input.a );
        params(2) = str2double( input.b );
        params(3) = str2double( input.lambda );
        params(4) = str2double( input.miu );
        if isfield( input, 'minor_step' )
            TimeEnd = timeStep( str2double( input.end ), str2double( input.minor_step ) );
        else
            TimeEnd = timeStep( str2double( input.end ) );
        end
        %
        model = @schnutea; % << change
        
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

