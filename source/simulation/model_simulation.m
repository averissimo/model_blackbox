function baranyi( )
%BARANYI Summary of this function goes here
%   Detailed explanation goes here

input = qs2struct(getenv('QUERY_STRING'));

Gompertz('parameters');
MEXmodel_global = 'Gompertz';
MEXmodelfullpath_global = strcat(pwd,'/lib/');

try
    %
    miu     = str2double( input.miu );
    lambda  = str2double( input.lambda );
    A       = str2double( input.A );
    TimeEnd = str2double( input.end );
    N       = str2double( input.N );
    %
    inicond = [N , 0];
    parameters = {'miu' 'lambda' 'A' };
    paravalues = [miu lambda A];
    %
    simdata = SBPDsimulate(MEXmodel_global,TimeEnd,inicond,parameters,paravalues);
    %
    M = [ simdata.statevalues(:,1) simdata.statevalues(:,2) ];
    printJson(M) 
catch
    fprintf(1,'{ "error": "error creating magic square" }\n')
end


end

