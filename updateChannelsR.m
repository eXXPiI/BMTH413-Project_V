function channels = updateChannelsR(channels, numChannels, Uold, deltaT)
    thresh = 1 + 0.5*(rand() - rand());
    for i = 1:numChannels
        point = channels(i, 1:2);
        %point is an x y pair
        Upoint = Uold(point(1), point(2));
        k = 1000000 + 100000*(rand() - rand());
        if(Upoint > thresh) %too much calcium larger k
            cutoff = 1 - exp(-k*deltaT);
        else %too little calcium smaller k
            cutoff = exp(-k*deltaT);
        end
        num = rand(1,1);
        if(num < cutoff) %if less then open
            channels(i,3) = 1;
        else %if greater or equal to then close
            channels(i,3) = 0;
        end
    end
end