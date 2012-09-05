function [ output ] = analytical_estimator( input, model , draw_plot )
%ANALYTICAL_ESTIMATOR Summary of this function goes here
%   Detailed explanation goes here
%#function lsqcurvefit

MAX_COUNT = 20;
COUNT_TEST = 5;

    try
        %% print html header that tells it is json data
        printHeader( 0 );
        %
        %% builds time (x) and values (y) matrices
        time_s_array = textscan(input.time,'%s','delimiter',';');
        value_s_array = textscan(input.values,'%s','delimiter',';');
        len = length(time_s_array{1});
        time = [];
        values = [];
        for i = 1:len
            time_aux = str2num(char(time_s_array{1}(i)));
            values_aux = str2num(char(value_s_array{1}(i)));
            %
            padadd( time , time_aux );
            padadd(values, values_aux);
        end
        %% building string 
        % starts by converting string to json
        estimat = strrep(input.estimation, '%22' , '"');
        estimat = strrep(estimat, '%7B' , '{');
        estimat = strrep(estimat, '%7D' , '}');
        % reads json
        estimation = build_estimation( loadjson( estimat ) );
        % sorting by parameters name (convention!)
        [res index] = sort(estimation.parameters.names);
        %
        %% model (with parameters sorted by name)
        % parameters' name reflects what is defined in the application
        % params(1): A
        % params(2): lambda
        % params(3): miu
        %
        %% Estimation
        options = optimset('DerivativeCheck','on','FinDiffType','central','Display','off');
        % options retrieved from build estimation
        options.MaxIter = estimation.optimization.options.maxiter;
        options.MaxFunEvals = estimation.optimization.options.maxfunevals;
        options.TolFun = estimation.optimization.options.tolfun;
        options.TolX = estimation.optimization.options.tolx;
        
        max_count = MAX_COUNT;
        count_test = COUNT_TEST;
        resnorm = Inf;
        ahat = [];
        output = [];
        beta0 = [];
        while max_count >= 0 && count_test >= 0
            %
            [ub,lb,beta0] = set_init_params(res, index, estimation );
            %fprintf(1,'b0: %f | %f | %f\n' , beta0(1) , beta0(2) , beta0(3));
            %
            [ahat_t,resnorm_t,~,~,output_t,~,~] = lsqcurvefit(model , beta0 , time , values , lb , ub , options );
            %fprintf(1,'%2d: %f | %f | %f (%f)\n' , max_count , ahat_t(1) , ahat_t(2) , ahat_t(3) , resnorm_t);
            %
            if all_params_changed(beta0,ahat_t)
                if resnorm_t < resnorm
                   resnorm = resnorm_t;
                   ahat = ahat_t;
                   output = output_t;
                end
                count_test = count_test - 1;
            else
                count_test = COUNT_TEST;
                max_count = max_count - 1;    
            end
        end

        fprintf(1,'{\n');

        for j = 1:length(res)
           fprintf( 1 , '\t"%s": %f' , res{index(j)} , ahat(j) );
           fprintf(1,',\n');
        end
        fprintf(1,'\t"N": 0,\n\t"o": %.14f\n' , output.firstorderopt);
        fprintf(1,'}\n');
        %
        % if plot argument is true
        if draw_plot
            xrange= min(time):.01:max(time);
            hold on;
            [~,len] = size(time);
            for j = 1:len
                scatter(time(:,j),values(:,j));
            end
            plot(xrange,model(ahat,xrange),'r');
            hold off;
        end
    catch err
        msg = sprintf('{ "error": "%s" }\n',err.message);
        fprintf(1,'%s',msg);
    end

end

