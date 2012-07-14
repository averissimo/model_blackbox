function gompertz_sim( )
%BARANYI Summary of this function goes here
%   Detailed explanation goes here

%
% example:
% setenv('QUERY_STRING','miu=1.266&lambda=3.78826&A=0.665752&end=23&x_0=0.146912');
% setenv('QUERY_STRING','A=0.654608&lambda=3.777706&miu=0.875303&N=0.051472&end=100');

input = qs2struct(getenv('QUERY_STRING'));

Gompertz('parameters');
MEXmodel_global = 'Gompertz';

try
    %
    miu     = str2double( input.miu );
    lambda  = str2double( input.lambda );
    A       = str2double( input.A );
    TimeEnd = timeStep( str2double( input.end ) );
    N       = str2double( input.N );
    %
    inicond = [N , 0];
    parameters = {'miu' 'lambda' 'A' };
    paravalues = [miu lambda A];
    %
    options.abstol = 1e-6;%1e-6;
    options.reltol = 1e-6;%1e-6;
    options.minstep = 0;%0;
    options.maxstep = inf;%inf;
    options.maxnumsteps = 100000;%100000;
    %
    [~ simdata]=evalc(sprintf('SBPDsimulate(MEXmodel_global,TimeEnd,inicond,parameters,paravalues);'));
    %simdata = SBPDsimulate(MEXmodel_global,TimeEnd,inicond,parameters,paravalues,options);
    %
    M = [ simdata.statevalues(:,2) simdata.statevalues(:,1)];
    printJson(M)
catch err
    fprintf(1,'{ "error": "%s" }\n',err.message)
end


end

