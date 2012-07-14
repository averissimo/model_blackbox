function baranyi_sim( )
%BARANYI Summary of this function goes here
%   Detailed explanation goes here
%#function SBPDsimulate

%
% example:
% setenv('QUERY_STRING','m=5.000000,&y0=0.001381,&h0=2&ymax=5.000000,&mu=0.246028,&v= 0.325587,&N=0.120706&end=20');
% setenv('QUERY_STRING','h0=1.817612&m=29.956636&mu=0.927801&N=0.0&v=1.038042&y0=3.82986&ymax=7.711657&end=100');	
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
    [~, simdata] = eval('SBPDsimulate(MEXmodel_global,TimeEnd,inicond,parameters,paravalues);');
    %simdata = SBPDsimulate(MEXmodel_global,TimeEnd,inicond,parameters,paravalues);
    %
    M = [ simdata.statevalues(:,2) simdata.statevalues(:,1)];
    printJson(M) 
catch err
    printHeader();
    fprintf(1,'{ "error": "%s" }\n',err.message);
end


end

