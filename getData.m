function [ sample ] = getData(sampleFrame, samplePos, sampleAngle, sampleSize)

sample = zeros(sampleSize,1);
xVal = round(abs(sin(deg2rad(sampleAngle)))*(sampleSize/2));
yVal = round(abs(cos(deg2rad(sampleAngle)))*(sampleSize/2));
sample(:,1) = improfile(sampleFrame,[samplePos(2)+xVal,samplePos(2)-xVal],[samplePos(1)-yVal,samplePos(1)+yVal],sampleSize);
% 
% for x = 1 : 1 : size(sample,1)
%     
%     if isnan(sample(x,1))
%         error('isnan');
%     end
%     
% end

end

