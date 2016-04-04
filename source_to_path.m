
%% add to path whole library
[current_path, ~, ~] = fileparts( mfilename('fullpath'));
toolbox_path = strcat( current_path,'/toolbox' );
models_path  = strcat( current_path,'/models' );
addpath(genpath(toolbox_path),genpath(models_path));