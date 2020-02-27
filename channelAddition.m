function matrix = channelAddition(channels, numChannels, J, numPoints)
    matrix = zeros(numPoints, numPoints);
    
    for i = 1:numChannels
        point = channels(i,1:2);
        matrix(point(1), point(2)) = matrix(point(1), point(2)) + J*channels(i,3);
    end
end