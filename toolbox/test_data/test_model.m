  

%% data
% uncomment and adapt to use sample test data
% input = get_inputs( nargin, 1, 'estimator', 'gompertza');
% or you can user csvread, load, etc..
% we use data directly from a http://kdbio.inesc-id.pt/bgfit experiment
data = dataset('File', 'example.csv', 'Delimiter',',','ReadVarNames',1);

% index of the replicate
i = 560;
% reduce the dataset to only this replicate
data_reduced = data( data.index == i, 1:2);
% get from dataest
time   = transpose( data_reduced.time );
values = transpose( data_reduced.n );

%% define model
model = @gompertza;
pnames = {'A','lambda','miu','N'};


ub = [20, 20, 3, 1];
lb = [0, 0, 0.001, 0];

s = params2query( pnames, lb, 'param_bottom', ub, 'param_top', time, 'time', values, 'values' );
if iscell(s), s = s{1}; end
input = get_inputs(1,s);

%% debug information and plot
% draw plot of the estimation? (1: yes, 0: no)
draw_flag = 1;
% show debug info? (1: yes, 0: no)
debug_flag = 1;

%% perform parameter estimation
[output,output_string] = analytical_estimator(input, model, struct, draw_flag, debug_flag);