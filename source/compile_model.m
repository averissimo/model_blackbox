function compile_model(model_path)
%% declare functions that will be called
%$function est_gompertz
%#function mex
%#function simplexSB
%#function defaultcostparameterestimationSBPD
%#function SBPDparameterestimation

global MEXmodel_global MEXmodelfullpath_global MEX_DO_NOT_CREATE;

MEX_DO_NOT_CREATE = 0;
MEXmodelfullpath_global = strcat(pwd,'/lib/');
try
    %% html header
    printHeader( 0 );
    %
    %% measurements
    %% model
    model = SBmodel( model_path );
    struct = SBstruct(model);
    MEXmodel_global = struct.name;
    makeTempMEXmodelSBPD( model );
    
    fprintf(1,'mex model can be located at\n');
    fprintf(1,'%s%s.mexglx\n',MEXmodelfullpath_global,MEXmodel_global);
catch e
    fprintf(1,'{ "error": "%s" }\n',e.message);
end

end

function printHeader(len)
fprintf(1,'Content-type: application/json; charset=utf-8\n');
fprintf(1,'Cache-control: max-age=0, private, must-revalidate\n');
if ( len > 0)
    fprintf(1,'Content-length: %i\n',len);
end
fprintf(1,'Access-Control-Allow-Origin: *\n');


fprintf(1,'\r\n');
end
