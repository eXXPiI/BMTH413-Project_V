D = 1;
startX = 0;
endX = 1;
startY = 0;
endY = 1;
numPoints = 10;
numChannels = 40;
deltaX = (endX - startX)/numPoints;
deltaY = (endY - startY)/numPoints;

%find deltaT:
deltaT = ((deltaX^2)*(1/3))/D;
%deltaT = ((deltaX^2)*(deltaY^2)*(1/9))/D;
old = 1;
J = 0.1/deltaT;
U = zeros(numPoints, numPoints, 2);

%channels = x, y, off boolean
channels = findChannels(numChannels, U);
%update channel boolean status
channels = updateChannels(channels, numChannels, U(:,:,old), deltaT);
%create matrix
channelMat = channelAddition(channels, numChannels, J, numPoints);

