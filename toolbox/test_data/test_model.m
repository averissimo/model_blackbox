%% data
% uncomment and adapt to use sample test data
% input = get_inputs( nargin, 1, 'estimator', 'gompertza');
% or you can user csvread, load, etc..
% we use data directly from a http://kdbio.inesc-id.pt/bgfit experiment
data_filename     = '203';
data_filename_ext = '.csv';
data_file         = strcat( data_filename, data_filename_ext );
data = dataset('File', data_file, 'Delimiter',',','ReadVarNames',1);


% index of the replicate
i = 512;
% reduce the dataset to only this replicate
data_reduced = data( data.index == i, 1:2);
% get from dataest
time   = transpose( data_reduced.time );
values = transpose( data_reduced.n );

%% define modeli
model = @gompertza;
pnames = {'A','lambda','miu','N'};
ub = [20, 20, 3    ,   1];
lb = [0  ,  0, 0.001, -15];

% create 3 sample intervals to test
intervals = cell(1);
intervals{1} = [0, Inf ];
intervals{2} = [0, 4, Inf ];
intervals{3} = [0, 6, Inf ];

[result, sum_result] = estimate_intervals(data_reduced, pnames, intervals, 2, lb, ub, model,1);
