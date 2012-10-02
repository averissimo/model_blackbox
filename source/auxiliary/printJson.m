function printJson(M)
    json = savejson('result',M);
    printHeader( length(json) );
    
    if isreal(M)
        fprintf(1,'%s\n\n',json);
    else
        fprintf(1,'{ "error": "Simulated parameters return a complex number" }\n');
    end
    
end