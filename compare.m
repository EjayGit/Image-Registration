function [ minValue, posDif, dataError ] = compare(comparisonData1, comparisonData2)

dataError = 0;
minValue = [];
posDif = [];

% Find and order the most significant locations with relation to the
% size of the gradients in the 2nd data set, and 1st data set. First column
% is for grad value, 2nd for pixel (position).
sorted1 = sortData2(comparisonData1,2,1,1);
sorted2 = sortData2(comparisonData2,2,1,1);

% If the sorted data is too small to enable a resonable comparison, call an
% error.
if (size(sorted1,1) < 1) || (size(sorted2,1) < 1)
    dataError = 1;
    return
    %error('There are not enough peaks and troughs in this data set');
end

% Determine the number of peaks in the 1st data set that shall be tested
% against the 2nd data set, using the 2nd data set to identify this number.
testNum = floor(size(sorted2,1)/2);
if testNum < 3
    testNum = size(sorted2,1);
end
if size(sorted1,1) < testNum
    testNum = size(sorted1,1);
end

% For each peak to be tested, find the difference between the gradients,
% and note the 'confidence' of each test, and select the best fit using the
% confidence values.
[ testResult, dataError ] = testGrads2(sorted1,sorted2,testNum);
if dataError == 1
    return
end
%[ testResult ] = testGrads3(sorted1,sorted2);
[ minValue, i ] = min(testResult(:,3));

posDif = testResult(i,2);

end

