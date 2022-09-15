% RegistrationTest.m

clear all;

% Load video into obj.
fileIn = VideoReader('IR1a.mp4');
startFrame = 1;
for initialFrame = 1 : 1 : startFrame-1
    % Read frame.
    frame = readFrame(fileIn);
end

frame = readFrame(fileIn);
% Convert to BW from RGB.
frame = rgb2gray(frame);

figure(1);
imshow(frame);
figure(2);
imshow(frame);

noOfTests = 5;
testRadiusIncrement = 3;
sampleSize = 201;
smootherSpan = 10;
estReg = 15;

% This initial for loop is set up for 5 tests.
result1 = [];
result2 = [];
result3 = [];
result4 = [];
result5 = [];

sampleSum = [];

for run = 1 : 1 : 100
    
    % Random angle of sample.
    rng('shuffle');
    sampleAngle = randi(180,1,1);

    % Determine initial sample centre position.
    initialPos = findInitialPos(fileIn.Height, fileIn.Width, sampleSize, sampleAngle, noOfTests, testRadiusIncrement);
    initialSample = getData(frame,initialPos,sampleAngle,sampleSize);
    initialSD = std(initialSample);
    sampleSum = cat(1,sampleSum, initialSample);
    if initialSD == 0
        continue
    end
    drawline(initialPos, sampleAngle, sampleSize);

    for test = 1 : 1 : noOfTests

        % Find list of points for each test.
        [ secondaryPoints, segmentAngle ] = findSecondaryPoints(initialPos, test, sampleAngle);
        result = zeros(size(secondaryPoints,1),3);

        for point = 1 : 1 : size(secondaryPoints,1)

            secondarySample = getData(frame, secondaryPoints(point,:),sampleAngle,sampleSize);
            sampleSum = cat(1,sampleSum, secondarySample);
            drawline(secondaryPoints(point,:), sampleAngle, sampleSize);

            % Smooth data.
            initialSmoothed = smooth(initialSample,smootherSpan);
            secondarySmoothed = smooth(secondarySample,smootherSpan);

            % Find gradients.
            initialGradients = diff(initialSmoothed);
            secondaryGradients = diff(secondarySmoothed);

            % Sum gradients.
            initialComparison = gradSelect(initialGradients, estReg);
            secondaryComparison = gradSelect(secondaryGradients, estReg);

            % Carry out test, returning the std dev for each position.
            [ stdDev, posDif, dataError ] = compare(initialComparison, secondaryComparison);
            if dataError == 1
                continue
            end

            % Save std dev for each position in a format east to plot.
            result(point,:) = [ (sampleAngle+(segmentAngle*point)), stdDev, posDif ];

        end

        % Tidy values. If an angle is greater than 360, subtract '360'.
        for x = 1 : 1 : size(secondaryPoints,1)
            if result(x,1) > 360
                result(x,1) = result(x,1) - 360;
            end
        end
        
        % Concatenate the result onto the appropriate results list at the
        % correct corresponding angle.
        if test == 1
            result1 = cat(1,result1,result);
        elseif test == 2
            result2 = cat(1,result2,result);
        elseif test == 3
            result3 = cat(1,result3,result);
        elseif test == 4
            result4 = cat(1,result4,result);
        elseif test == 5
            result5 = cat(1,result5,result);
        end 
        
    end
    
end

% Find average std dev for initial samples taken.
averageSD = std(sampleSum)

resultSmoother = 7;
result1 = sortData2(result1,1,1,1);
result1(:,2) = smooth(result1(:,2),resultSmoother);
result1SD = std(result1(:,2))
result1mean = mean(result1(:,2))

result2 = sortData2(result2,1,1,1);
result2(:,2) = smooth(result2(:,2),resultSmoother);
result2SD = std(result2(:,2))
result2mean = mean(result2(:,2))

result3 = sortData2(result3,1,1,1);
result3(:,2) = smooth(result3(:,2),resultSmoother);
result3SD = std(result3(:,2))
result3mean = mean(result3(:,2))

result4 = sortData2(result4,1,1,1);
result4(:,2) = smooth(result4(:,2),resultSmoother);
result4SD = std(result4(:,2))
result4mean = mean(result4(:,2))

result5 = sortData2(result5,1,1,1);
result5(:,2) = smooth(result5(:,2),resultSmoother);
result5SD = std(result5(:,2))
result5mean = mean(result5(:,2))

figure;
hold on
axis([0 6 0 10]);
title('Mean and Std Dev');
plot([1:1:5],[result1mean result2mean result3mean result4mean result5mean],'b-x',[1:1:5],[result1SD result2SD result3SD result4SD result5SD],'r-x');
hold off

% Plot the std devs for each test on one plot
figure;
hold on
axis([0 360 0 14]);
title('r = 3. p = 8');
plot(result1(:,1),result1(:,2),'b-');
hold off
figure;
hold on
axis([0 360 0 14]);
title('r = 6. p = 16');
plot(result2(:,1),result2(:,2),'m-');
hold off
figure;
hold on
axis([0 360 0 14]);
title('r = 9. p = 24');
plot(result3(:,1),result3(:,2),'r-');
hold off
figure;
hold on
axis([0 360 0 14]);
title('r = 12. p = 32');
plot(result4(:,1),result4(:,2),'k-');
hold off
figure;
hold on
axis([0 360 0 14]);
title('r = 15. p = 40');
plot(result5(:,1),result5(:,2),'g-');
hold off
figure;
hold on
axis([0 360 0 14]);
title('r = all');
plot(result1(:,1),result1(:,2),'b-');
plot(result2(:,1),result2(:,2),'m-');
plot(result3(:,1),result3(:,2),'r-');
plot(result4(:,1),result4(:,2),'k-');
plot(result5(:,1),result5(:,2),'g-');
hold off
