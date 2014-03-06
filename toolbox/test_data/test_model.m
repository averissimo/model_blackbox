%% data
% uncomment and adapt to use sample test data
% input = get_inputs( nargin, 1, 'estimator', 'gompertza');
% or you can user csvread, load, etc..
% we use data directly from a http://kdbio.inesc-id.pt/bgfit experiment
[parent, ~, ~] = fileparts(mfilename('fullpath'));
file.data_dir = 'data';
file.parent = strcat(parent,'/',file.data_dir);
file.ext  = '.csv';

print_flag = 0;

data_files = dir(strcat(file.parent,'/*',file.ext));

data = dataset();
for f = data_files'

    file.name = f.name;
    file.file = strcat(file.parent,'/',file.name);
    file.data = dataset('File', file.file, 'Delimiter',',','ReadVarNames',1);
    data = cat(1, data, file.data);
end

[best, index_t, result_t, sum_result_t] = data_intervals( data.time, data.n, data.index, print_flag );
result = dataset( index_t, best.ids, best.residuals, best.intervals, best.params', result_t, sum_result_t);
result.Properties.VarNames = {'index','best_id', 'best_residual', 'best_interval', 'best_param', 'all_results','summary_of_results'};
