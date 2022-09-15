function [ smallestDiff, closestIndice ] = findClosestValue2( vector, value, ignoreValues )

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function returns the smallest difference of all the differences between
% the input value and all the values in the vector. It also returns the
% indice that had the smallest difference.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

smallestDiff = [];

for test = 1 : 1 : size(vector,1)
    if ignoreValues(test,1) == 1
        continue
    else
        if isempty(smallestDiff)
            smallestDiff = abs(value - vector(test,1));
        end
        diff = abs(value - vector(test,1));
        if diff <= abs(smallestDiff)
            smallestDiff = value - vector(test,1);
            closestIndice = test;
        end
    end
end

end

