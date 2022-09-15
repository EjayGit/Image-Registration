%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% This function needs to be upgraded to include each of the largest
%%% gradient positions as the primary. This is to stop a moving tgt that
%%% causes the largest gradient to be the primary gradient and poorly
%%% influencing the registration estimation. A suggestion how to do this
%%% would be to hold the feature information and use the same features
%%% until they get close to the edge of the sample, analysing new features
%%% as they appear.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% For each gradient in the 2nd data set, in order of magnitude, largest
% first, test the gradients in their relative positions against the
% gradients of the 1st data set, measuring the distance between those
% nearest gradients. 1st column = The value that the primary gradient
% shifted to for each comparison.
% 2nd column = The total sum of differences for each corresponding shift.
% 3rd column = The position difference for that 
% 4th column = The mean difference taking into account the initial shift.
% 5th column = The std dev of the mean difference.
% Only the 3rd to 5th columns are passed to the output, as the 1st and 2nd
% columns hold temporary information.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ testResult, dataError ] = testGrads2(sorted1,sorted2,testNum)

% Initialise temporary results matrix. First column show results for 
testResult = zeros(testNum,5);
dataError = 0;
% delete = [];

% Identify whether it is positive or negative.
if sorted2(1,1) > 0
    % Check against each potential comparison gradient.
    for secondaryGrad = 1 : 1 : testNum
        % If the gradient is positive like the primary, compare the
        % gradients.
%         if sorted1(secondaryGrad,1) > 0
            primaryPos = sorted2(1,2);
            secondaryPos = sorted1(secondaryGrad,2);
            posDiff = primaryPos - secondaryPos;
            % Go through top testNum gradients from sorted2 comparing to
            % sorted1 gradients.
            for test = 1 : 1 : testNum
                testResult(test,1) = sorted2(test,2) - posDiff;
            end
            % For every significant gradient to be compared, find the
            % smallest difference between the locations of the comparable
            % gradients.
            for tempTest = 1 : 1 : size(testResult,1)
                [ testResult(tempTest,2), ~ ] = findClosestValue( sorted1(:,2), testResult(tempTest,1) );
            end
            % Store into main sweep test results.
            testResult(secondaryGrad,3) = posDiff;
            testResult(secondaryGrad,4) = posDiff + mean(testResult(:,2));
            testResult(secondaryGrad,5) = std(testResult(:,2));
%         else
%             delete = cat(1,delete,secondaryGrad);
%         end
    end
elseif sorted2(1,1) < 0
    % Check against each potential comparison gradient.
    for secondaryGrad = 1 : 1 : testNum
        % If the gradient is negative like the primary, compare the
        % gradients.
        %if sorted1(secondaryGrad,1) < 0
            primaryPos = sorted2(1,2);
            secondaryPos = sorted1(secondaryGrad,2);
            posDiff = primaryPos - secondaryPos;
            % Go through top 'testNum' gradients from sorted2 comparing to
            % sorted1 gradients.
            for test = 1 : 1 : testNum
                testResult(test,1) = sorted2(test,2) - posDiff;
            end
            % For every significant gradient to be compared, find the
            % smallest difference between the locations of the comparable
            % gradients.
            for tempTest = 1 : 1 : size(testResult,1)
                [ testResult(tempTest,2), ~ ] = findClosestValue( sorted1(:,2), testResult(tempTest,1) );
            end
            % Store into main sweep test results.
            testResult(secondaryGrad,3) = posDiff;
            testResult(secondaryGrad,4) = posDiff + mean(testResult(:,2));
            testResult(secondaryGrad,5) = std(testResult(:,2));
        %end
    end
else
    dataError = 1;
    %error('The largest gradient is 0 and therefore registration cannot be estimated for this sample');
end

testResult = [testResult(:,5),testResult(:,4)];

end

