function TEMPLATE_sim( )
%BARANYI Summary of this function goes here
%   Detailed explanation goes here

%
% example:
% setenv('QUERY_STRING','miu=1.266&lambda=3.78826&A=0.665752&end=23&x_0=0.146912');
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
    [~, simdata]=evalc(sprintf('SBPDsimulate(MEXmodel_global,TimeEnd,inicond,parameters,paravalues);'));
    %simdata = SBPDsimulate(MEXmodel_global,TimeEnd,inicond,parameters,paravalues);
    %
    M = [ simdata.statevalues(:,2) simdata.statevalues(:,1)];
    printJson(M) 
catch err
    fprintf(1,'{ "error": "%s" }\n',err.message)
end


end

