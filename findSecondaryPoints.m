function [ secondaryPoints, segmentAngle ] = findSecondaryPoints(initialPos, test, sampleAngle)

numberOfPoints = 8*test;
secondaryPoints = zeros(numberOfPoints,2);
radius = test*3;
segmentAngle = 360/numberOfPoints;

% Find points
for i = 1 : 1 : numberOfPoints
    
    angle = deg2rad(sampleAngle+(segmentAngle*i));
    secondaryPoints(i,:) = [initialPos(1)+(round(sin(angle)*radius)),initialPos(2)+(round(cos(angle)*radius))];
    
end

end

