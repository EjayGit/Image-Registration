function [ sorted ] = sortData(comparisonData)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Sorts gradients into order of madnitude (using the absolute value).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sizeData = size(comparisonData.grad,1);
sorted = zeros(sizeData,3);
highestElement = 0;
delete = [];
for sort = 1 : 1 : sizeData
    highestValue = 0;
    for unsort = 1 : 1 : sizeData
        if sorted(unsort,3) == 0
            if abs(comparisonData.grad(unsort)) > highestValue
                highestElement = unsort;
                highestValue = abs(comparisonData.grad(unsort));
            end
        elseif sorted(unsort,3) == 1
            continue
        else
            error('Erroneous checkbit');
        end
    end
    sorted(sort,1:2) = [ comparisonData.grad(highestElement), comparisonData.gradLoc(highestElement) ];
    sorted(highestElement,3) = 1;
    if (highestElement == 1) || (highestElement == sizeData)
        delete = cat(2,delete,sort);
    end
end
sorted(delete,:) = [];
sorted(:,3) = [];

end

