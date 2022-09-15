function drawline(initialPos, sampleAngle, sampleSize)

figure(1);

xVal = sin(deg2rad(sampleAngle))*(sampleSize/2);
yVal = cos(deg2rad(sampleAngle))*(sampleSize/2);
line([initialPos(2)+xVal,initialPos(2)-xVal],[initialPos(1)-yVal,initialPos(1)+yVal]);

end