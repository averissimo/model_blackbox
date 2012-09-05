function bool = all_params_changed( beta0 , ahat )
    bool = 1;
    for i = 1:length(beta0)
        if beta0(i) == ahat(i)
            bool = 0;
            break;
        end
    end
end
