function printJson(M)
    json = savejson('result',M);
    printHeader( length(json) );
    fprintf(1,'%s\n\n',json);
    
end