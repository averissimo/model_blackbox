  

%% data
% uncomment and adapt to use sample test data
% input = get_inputs( nargin, 1, 'estimator', 'gompertza');




%% define model
model = @gompertza;

%% debug information and plot
% draw plot of the estimation? (1: yes, 0: no)
draw_plot = 1;
% show debug info? (1: yes, 0: no)
debub = 1;

flag = 0;
if nargin > 1 && draw_plot
    flag = 1;
end
debug_flag = 0;
if nargin > 2 && debug
    debug_flag = 1;
end

%% perform parameter estimation
[output,output_string] = analytical_estimator(input, model, struct, flag, debug_flag);