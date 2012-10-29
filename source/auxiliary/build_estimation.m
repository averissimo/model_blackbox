% Model Blackbox
% Copyright (C) 2012-2012  André Veríssimo
%
% This program is free software; you can redistribute it and/or
% modify it under the terms of the GNU General Public License
% as published by the Free Software Foundation; version 2
% of the License.
%
% program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program; if not, write to the Free Software
% Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

function [ estimation ] = build_estimation( params )
%BUILD_ESTIMATION Summary of this function goes here
%   Detailed explanation goes here

    %% DEFINE THE ESTIMATION INFORMATION (STRUCTURE)
    estimation = [];
    % Global parameters
    % Names    Lower bounds  Upper bounds
    len = length(params.param_bottom);
    %paramdata = cell(len,3);
    paramdata = struct;
    for x = 1:len
        paramdata.names{x,1} = params.param_names{1}{x};
        paramdata.lowbounds(x,1) = params.param_bottom(x);
        paramdata.highbounds(x,1) = params.param_top(x);
    end
    icdata = struct;%cell(len,3);
    if isfield( params , 'ic_names')
        % Initial conditions (always experiment dependend)
        % Names    Lower bounds  Upper bounds
        len = length(params.ic_bottom);

        for x = 1:len
            icdata.names{x,1} = params.ic_names{1}{x};
            icdata.lowbounds(x,1) = params.ic_bottom(x);
            icdata.highbounds(x,1) = params.ic_top(x);
        end
        % Local (experiment dependend) parameters
        % Names    Lower bounds  Upper bounds
    end
    paramdatalocal = struct();

    % Model and experiment settings
    estimation.modelindex = 1;
    estimation.experiments.indices = 1;
    estimation.experiments.weight = 1;

    % Always needed (do not change ... unless you know what you do)
    estimation.parameters = paramdata;
    estimation.parameterslocal = paramdatalocal;
    estimation.initialconditions = icdata;

    % Optimization settings
    estimation.optimization.method = 'simplexSB';
    estimation.optimization.options.maxfunevals = 50000;
    estimation.optimization.options.maxiter = 20000;
    estimation.optimization.options.tolfun = 1e-14;
    estimation.optimization.options.tolx = 1e-14;

    % Integrator settings
    estimation.integrator.options.abstol = 1e-6;
    estimation.integrator.options.reltol = 1e-6;
    estimation.integrator.options.minstep = 0;
    estimation.integrator.options.maxstep = Inf;
    estimation.integrator.options.maxnumsteps = 10000;

    % Flags
    estimation.initialconditionsFlag = 1; % do use initial conditions from measurement data (if available)
    estimation.displayFlag = 1; % show iterations and final message
    estimation.scalingFlag = 1; % scale by mean values
    estimation.timescalingFlag = 0; % do not apply time-scaling

end
