function channels = findChannels(numChannels, U)

    [width, hieght, ~] = size(U);
    
    channels = zeros(numChannels,3);

    for i = 1:numChannels
        channels(i,1) = round(rand(1,1)*(width-1)+1);
        channels(i,2) = round(rand(1,1)*(hieght-1)+1);
    end
end