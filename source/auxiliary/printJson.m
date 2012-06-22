function printJson(M)
    json = savejson('result',M);
    printHeader( length(json) );
    fprintf(1,'%s\n\n',json);
    
end

function printHeader(len)
    fprintf(1,'Content-type: application/json; charset=utf-8\n');
    fprintf(1,'Cache-control: max-age=0, private, must-revalidate\n');
    fprintf(1,'Content-length: %i\n',len);
    fprintf(1,'Access-Control-Allow-Origin: *\n');


    fprintf(1,'\r\n');
end