function x = qs2struct( qs )
% return the query string as a structure
% each field is a paramter name
% the value of the field is its value as a string

    % an example query string:
    % myinput=test&size=2&num=10

    % get the indeces of the characters that divide names and fields
    div = [0,strfind(qs,'&'),length(qs)+1];
    eq = strfind(qs,'=');

    x.querystring = qs;
    for i=1:length(eq)
        field = qs(div(i)+1:eq(i)-1); %field string
        value = qs(eq(i)+1:div(i+1)-1); %value stirng
        x = setfield(x,field,value); %place in structure
    end

end

