function [higherbound,lowerbound,beta0] = set_init_params(res, index, estimation )
    higherbound = zeros( length(res) , 1);
    lowerbound = zeros( length(res) , 1);
    beta0 = zeros( length(res) , 1);
    for j = 1:length(res)
        lowerbound(j) = estimation.parameters.lowbounds(index(j),1);
        higherbound(j) = estimation.parameters.highbounds(index(j),1);
        if lowerbound(j) == higherbound(j)
           higherbound(j) =  higherbound(j) + abs( higherbound(j)*0.001 );
        end
        beta0( j ) = lowerbound( index(j) ) + rand*( higherbound( index(j) )-lowerbound( index(j) ) );
    end
end
