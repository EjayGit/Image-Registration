function [ initialPos ] = findInitialPos(Height, Width, sampleSize, sampleAngle, noOfTests, testRadiusIncrement)

% Find the box boundary of the sample.
sampleBoundary = ceil(abs([sin(deg2rad(sampleAngle))*sampleSize,cos(deg2rad(sampleAngle))*sampleSize]));

% Find the size of the boundary of the left and right borders.
LRBorder = sampleBoundary(1)+(noOfTests*testRadiusIncrement);
UDBorder = sampleBoundary(2)+(noOfTests*testRadiusIncrement);

% Find the x and y position for the initial centre sample.
rng('shuffle');
y = randi((Height-(2*UDBorder)),1,1)+UDBorder;
rng('shuffle');
x = randi((Width-(2*LRBorder)),1,1)+LRBorder;

initialPos = [y,x];

% if x<0 | y<0
%     error('y or x is negative');
% end

end

