function [ smallestDiff, closestIndice ] = findClosestValue( vector, value )

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function returns the smallest difference of all the differences between
% the input value and all the values in the vector. It also returns the
% indice that had the smallest difference.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

smallestDiff = abs(value - vector(1,1));
closestIndice = 1;

for test = 1 : 1 : size(vector,1)
    diff = abs(value - vector(test,1));
    if diff < abs(smallestDiff)
        smallestDiff = value - vector(test,1);
        closestIndice = test;
    end
end

end

