function print_error_json( err , fid, remove_bracket )
%PRINT_ERROR_JSON Summary of this function goes here
%   Detailed explanation goes here

    if nargin <= 2 || not(remove_bracket)
        fprintf(fid,'{\n');
    end
    fprintf(fid,'\t"error":\t"%s"\n',err.message);
    len = length(err.stack);
    for i = 1:len
        fprintf(fid,'',i);
        fprintf(fid,'\t"stack_%d":\t[line: %d",\t"name":"%s",\tfile:"%s"]\n', i, err.stack(i).line, err.stack(i).name  , err.stack(i).file);
    end
    fprintf(fid,'}\n');
end
