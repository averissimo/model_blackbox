function [ output ] = analytical_estimator( input, model , custom_options, draw_plot, debug )
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
        %% Options for estimation
        options = optimset('DerivativeCheck','on','FinDiffType','central','Display','off');
        % options retrieved from build estimation
        options.MaxIter = estimation.optimization.options.maxiter;
        options.MaxFunEvals = estimation.optimization.options.maxfunevals;
        options.TolFun = estimation.optimization.options.tolfun;
        options.TolX = estimation.optimization.options.tolx;
        
        custom_fieldnames = fieldnames(custom_options);
        for j = 1:length(custom_fieldnames);
            options.(char(custom_fieldnames(j))) = custom_options.(char(custom_fieldnames(j)));
        end
        
        % sorting by parameters name (convention!)
        [res index] = sort(lower(estimation.parameters.names));
        %
        %% model (with parameters sorted by name)
        % parameters' name reflects what is defined in the application
        % params(1): A
        % params(2): lambda
        % params(3): miu
        %
        max_count = MAX_COUNT;
        count_test = COUNT_TEST;
        resnorm = Inf;
        ahat = [];
        output = [];
        beta0 = [];
        while max_count >= 0 && count_test >= 0
            %
            [ub,lb,beta0] = set_init_params(res, index, estimation );
            if debug
                fprintf(1,'b0: ');
                for j = 1:length(beta0)
                    fprintf(1,'%f | ' , beta0(j) );
                end
                fprintf(1,' start point for parameters\n');
            end
            [ahat_t,resnorm_t,~,~,output_t,~,~] = lsqcurvefit(model , beta0 , time , values , lb , ub , options );
            if debug
                fprintf(1,'%2d: ', max_count);
                for j = 1:length(ahat_t)
                    fprintf(1,'%f | ' , ahat_t(j));
                end
                fprintf(1,'(%f)\n' , resnorm_t);
            end
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
           fprintf( 1 , '\t"%s": %f' , estimation.parameters.names{index(j)} , ahat(j) );
           fprintf(1,',\n');
        end
        fprintf(1,'\t"o": %.14f\n' , resnorm);
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

