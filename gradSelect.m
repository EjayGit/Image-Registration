function dataOut = gradSelect(data, absReg)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function provides a structure carrying positive and negative parts
% to the value of gradients and the locations of those gradients. These are
% both in the same structure elements together and are not separated.
% eg.
% sample.grad    = [ -2 13 -8  3   -4  ]   = These are the sums of the gradients.
% sample.gradloc = [ 14 56 102 181 365 ] = These are the locations of the start of the gradients, in terms of pixels.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

data((data>-0.001)&(data<0.001))=0;

sample.grad = [];
sample.gradLoc = [];
tempGrad = 0;

% Iniitialise the value of 'flip' and mark the location of the pos of neg
% pixel.
if data(absReg)>0
    flip = 1;
elseif data(absReg)<0
    flip = -1;
elseif data(absReg)==0
    % This line of code is not ideal as is assumes that if the first data
    % read has a gradient of 0, it is positive, and this could cause errors
    % when comparing later, ie. a positive feature could be found to have a
    % gradient sum of 0. This assumption should be reviewed.
    flip = 1;
end
sample.gradLoc = absReg;
tempGrad = tempGrad + data(absReg);
% Start from a value that corresponds to estimated movement, and end at the
% max value - estimated movement.
for pixel = absReg+1 : 1 : (size(data,1) - absReg)
    if data(pixel)>0
        if flip == -1
            sample.grad = cat(1,sample.grad, tempGrad);
            flip = 1;
            sample.gradLoc = cat(1, sample.gradLoc, pixel);
            tempGrad = 0;
        end
        tempGrad = tempGrad + data(pixel);
    elseif data(pixel)<0
        if flip == 1
            sample.grad = cat(1,sample.grad, tempGrad);
            flip = -1;
            sample.gradLoc = cat(1, sample.gradLoc, pixel);
            tempGrad = 0;
        end
        tempGrad = tempGrad + data(pixel);
    elseif data(pixel) == 0
        if flip == 1
            tempGrad = tempGrad + data(pixel);
        elseif flip == -1
            tempGrad = tempGrad + data(pixel);
        end
    end
end

% Store the remaining data being summed appropriately depending on the
% value of 'flip'.
sample.grad = cat(1,sample.grad, tempGrad);

dataOut = zeros(size(sample.grad,1),2);
dataOut(:,1) = sample.grad;
dataOut(:,2) = sample.gradLoc;

end

