function [ result ] = normFun( M )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    num = size(M,1);
    nM = zeros(num,num);
    result = zeros(num,num);
    
    for i = 1:num
        nM(i,i) = sum(M(i,:));
    end

    for i = 1:num
        rsum = nM(i,i);
        for j = 1:num
            csum = nM(j,j);
            if((rsum==0)||(csum==0))
                result(i,j) = 0;
            else
                result(i,j) = M(i,j)/sqrt(rsum*csum);
            end
        end
    end
    
end

