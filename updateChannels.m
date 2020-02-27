function channels = updateChannels(channels, numChannels, Uold, deltaT)
    thresh = 1.2;
    for i = 1:numChannels
        point = channels(i, 1:2);
        %point is an x y pair
        Upoint = Uold(point(1), point(2));
        if(Upoint > thresh) %too much calcium larger k
            k = 1000000;
        else %too little calcium smaller k
            k = 1;
        end
        cutoff = exp(-k*deltaT);
        num = rand(1,1);
        if(num < cutoff) %if less then open
            channels(i,3) = 1;
        else %if greater or equal to then close
            channels(i,3) = 0;
        end
    end
end