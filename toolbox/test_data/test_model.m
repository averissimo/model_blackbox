  

%% data
% uncomment and adapt to use sample test data
% input = get_inputs( nargin, 1, 'estimator', 'gompertza');
% or you can user csvread, load, etc..
% we use data directly from a http://kdbio.inesc-id.pt/bgfit experiment
data = dataset('File', '203.csv', 'Delimiter',',','ReadVarNames',1);

% index of the replicate
i = 512;
% reduce the dataset to only this replicate
data_reduced = data( data.index == i, 1:2);
% get from dataest
time   = transpose( data_reduced.time );
values = transpose( data_reduced.n );

%% define model
model = @gompertza;
pnames = {'A','lambda','miu','N'};
ub = [20, 20, 3    ,   1];
lb = [0  ,  0, 0.001, -15];

fixed = 4;

intervals = [0, 6, Inf ];

[result] = estimate_intervals(data_reduced, pnames, intervals, 0, lb, ub, model);