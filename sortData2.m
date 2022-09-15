function [ dataOut ] = sortData2( dataIn, order, vector, dimension )

%%%%%%%%%%%%%%
% INCOMPLETE %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Sorts the data in order of magnitude with reference to any user selected
% vector, in any chosen dimension (1-3). The 'order' choses whether the
% data is to be ascending (1), or decending (2).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% The first column is the list of indicies in the original data sorted in
% size order. The second column is checked when the row has been sorted so
% it is not sorted twice.
indiceList = zeros(size(dataIn,dimension),2);

dataOut = zeros(size(dataIn));
vectorSize = size(dataIn,dimension);

%Set the min and max expected values.
floorValue = 0;

% Acquire a list of indices that represents the corrects sorting order.
for compareValue = 1 : 1 : vectorSize

    % Find the closest indice to the floor value.
    [ ~, closestIndice ] = findClosestValue2( dataIn(:,vector), floorValue, indiceList(:,2) );

    % Insert the indice to the indice list.
    indiceList(compareValue,1) = closestIndice;

    % Check off the indice that was sorted to ensure it is not checked
    % again.
    indiceList(closestIndice,2) = 1;

end

if order == 2
    
    % Reverse indiceList.
    count = 1;
    tempIndiceList = indiceList;
    for indice = size(indiceList,1) : -1 : 1
        
        indiceList(count,:) = tempIndiceList(indice,:);
        count = count + 1;
        
    end
    
end

for x = 1 : 1 : vectorSize
    
    dataOut(x,:) = dataIn(indiceList(x,1),:);
    
end

end