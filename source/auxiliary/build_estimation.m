function [ estimation ] = build_estimation( params )
%BUILD_ESTIMATION Summary of this function goes here
%   Detailed explanation goes here

    %% DEFINE THE ESTIMATION INFORMATION (STRUCTURE)
    estimation = [];
    % Global parameters
    % Names    Lower bounds  Upper bounds
    len = length(params.states);
    paramdata = cell(len,3);
    for x = 1:len
        paramdata{x,1} = params.states(x).name;
        paramdata{x,2} = params.states(x).bottom;
        paramdata{x,3} = params.states(x).top;
    end
    % Initial conditions (always experiment dependend)
    % Names    Lower bounds  Upper bounds
    len = length(params.initial);
    icdata = cell(len,3);
    for x = 1:len
        icdata{x,1} = params.initial(x).name;
        icdata{x,2} = params.initial(x).bottom;
        icdata{x,3} = params.initial(x).top;
    end
    % Local (experiment dependend) parameters
    % Names    Lower bounds  Upper bounds
    paramdatalocal = {
    };

    % Model and experiment settings
    estimation.modelindex = 1;
    estimation.experiments.indices = [1];
    estimation.experiments.weight = [1];

    % Optimization settings
    estimation.optimization.method = 'simplexSB';
    estimation.optimization.options.maxfunevals = 50000;
    estimation.optimization.options.maxiter = 20000;
    estimation.optimization.options.tolfun = 1e-10;
    estimation.optimization.options.tolx = 1e-10;

    % Integrator settings
    estimation.integrator.options.abstol = 1e-006;
    estimation.integrator.options.reltol = 1e-006;
    estimation.integrator.options.minstep = 0;
    estimation.integrator.options.maxstep = Inf;
    estimation.integrator.options.maxnumsteps = 10000;

    % Flags
    estimation.displayFlag = 1; % show iterations and final message
    estimation.scalingFlag = 1; % scale by mean values
    estimation.timescalingFlag = 0; % do not apply time-scaling
    estimation.initialconditionsFlag = 1; % do use initial conditions from measurement data (if available)

    % Always needed (do not change ... unless you know what you do)
    estimation.parameters = paramdata;
    estimation.parameterslocal = paramdatalocal;
    estimation.initialconditions = icdata;

end
