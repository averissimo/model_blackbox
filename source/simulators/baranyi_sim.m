function baranyi_sim( )
%BARANYI Summary of this function goes here
%   Detailed explanation goes here

%
% example:
% setenv('QUERY_STRING','m=5.000000,&y0=0.001381,&h0=2&ymax=5.000000,&mu=0.246028,&v= 0.325587,&N=0.120706&end=20');
	
input = qs2struct(getenv('QUERY_STRING'));

Baranyi('parameters');
MEXmodel_global = 'Baranyi';

try
    %
    mu      = str2double( input.mu );
    m       = str2double( input.m );
    v       = str2double( input.v );
    y0      = str2double( input.y0 );
    h0      = str2double( input.h0 );
    ymax    = str2double( input.ymax );
    TimeEnd = timeStep( str2double( input.end ) );
    N       = str2double( input.N );
    %
    inicond = [N , 0];
    parameters = {'mu' 'm' 'v' 'y0' 'ymax' 'h0' };
    paravalues = [mu m v y0 ymax h0];
    %
    simdata = SBPDsimulate(MEXmodel_global,TimeEnd,inicond,parameters,paravalues);
    %
    M = [ simdata.statevalues(:,2) simdata.statevalues(:,1)];
    printJson(M) 
catch
    fprintf(1,'{ "error": "error creating magic square" }\n')
end


end
