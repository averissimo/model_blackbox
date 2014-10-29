function [ time,values] = extract_time_values( input )
%EXTRACT_TIME_VALUES Summary of this function goes here
%   Detailed explanation goes here

input = escape_uri( input );

%% builds time (x) and values (y) matrices
time_s_array = textscan(input.time,'%s','delimiter',';','BufSize',length(input.time)+100);
value_s_array = textscan(input.values,'%s','delimiter',';','BufSize',length(input.values)+100);
len = length(time_s_array{1});
time = [];
values = [];
for i = 1:len
    time_aux = str2num(char(time_s_array{1}(i)));
    values_aux = str2num(char(value_s_array{1}(i)));
    %
    if isoctave()
      time = cat(2,time,time_aux);
      values = cat(2,values,values_aux);
    else
      padadd( time , time_aux );
      padadd(values, values_aux);
    end
end

[time_ord, t_ord] = sort(time);
for i = 1:length(time)
time_aux(i) = time(t_ord(i));
values_aux(i) = values(t_ord(i));
end
time = time_aux';
values = values_aux';

end

