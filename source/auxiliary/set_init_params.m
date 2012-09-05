function [higherbound,lowerbound,beta0] = set_init_params(res, index, estimation )
    higherbound = zeros( length(res) , 1);
    lowerbound = zeros( length(res) , 1);
    beta0 = zeros( length(res) , 1);
    for j = 1:length(res)
        lowerbound(index(j)) = estimation.parameters.lowbounds(index(j),1);
        higherbound(index(j)) = estimation.parameters.highbounds(index(j),1);
        beta0( index(j) ) = lowerbound( index(j) ) + rand*( higherbound( index(j) )-lowerbound( index(j) ) );
    end
end
