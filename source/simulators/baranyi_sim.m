function baranyi_sim( test_data )
%BARANYI Summary of this function goes here
%   Detailed explanation goes here
%#function SBPDsimulate

%
% example:
% setenv('QUERY_STRING','m=5.000000,&y0=0.001381,&h0=2&ymax=5.000000,&mu=0.246028,&v= 0.325587,&N=0.120706&end=20');

if nargin > 0 && test_data
    input = qs2struct('h0=0.733564&m=0.534439&mu=2.570644&N=0.042879&v=4.99849&y0=-4.858&ymax=0.000875&end=25');	
else
    input = qs2struct(getenv('QUERY_STRING'));
end

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
    [~, simdata] = evalc('SBPDsimulate(MEXmodel_global,TimeEnd,inicond,parameters,paravalues);');
    %simdata = SBPDsimulate(MEXmodel_global,TimeEnd,inicond,parameters,paravalues);
    %
    M = [ simdata.statevalues(:,2) simdata.statevalues(:,1)];
    printJson(M) 
catch err
    msg = sprintf('{ "error": "%s" }\n',err.message);
    printHeader(length(msg));
    fprintf(1,'%s',msg);
end


end

