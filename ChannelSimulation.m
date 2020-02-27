%% Preamble
% Program: ChannelSimulation.m
% Author: Jonathan Myers and Zach Forster
% Date: February 20, 2020
% Purpose: Simulate calcium particles.
% Arguments: None.
% Loads: None.
% Calls: None.
% Returns: None.

%% Setup
close all
clear
clc

%% Start
runNum = 100000;
numChannels = 50;
D = 100000;
Vp = 50;
numPoints = 50;
factor = 10; % Bigger than 8.

xlim = [0,1];
ylim = [0,1];
deltaX = (xlim(2) - xlim(1))/numPoints;
deltaY = (ylim(2) - ylim(1))/numPoints;

XVector = xlim(1)+deltaX:deltaX:xlim(2);
YVector = ylim(1)+deltaY:deltaY:ylim(2);

% find deltaT:
deltaT = ((deltaX^2)*(deltaY^2))/(factor*D);
%deltaT = ((deltaX^2)*(deltaY^2))/(0.125*D);
% find J
J = 0.01;

U0 = 1*ones(numPoints, numPoints);
U = ones(numPoints, numPoints, 2);

%channels = x, y, off boolean
channels = findChannels(numChannels, U);

modOP = 100;
num = runNum/modOP;
R(num) = struct('cdata',[],'colormap',[]);

for i = 1:runNum
    old = 1;
    %update channel boolean status
    channels = updateChannelsR(channels, numChannels, U(:,:,old), deltaT);
    %create matrix
    channelMat = channelAddition(channels, numChannels, J, numPoints);
    newChange = CalculateDiffusion(U,D,deltaT,deltaX,deltaY,old);
    U(:,:,2) = newChange - Vp*deltaT*(U(:,:,1)-U0) + channelMat;
    
    old = 2;
    %update channel boolean status
    channels = updateChannelsR(channels, numChannels, U(:,:,old), deltaT);
    %create matrix
    channelMat = channelAddition(channels, numChannels, J, numPoints);
    newChange = CalculateDiffusion(U,D,deltaT,deltaX,deltaY,old);
    U(:,:,1) = newChange - Vp*deltaT*(U(:,:,2)-U0) + channelMat;
    
    if mod(i,modOP) == 0
        figure(1);
        set(gcf,'color','w','position',[25,50,1500,700]);
        % set(gcf,'position',[25,50,700,700]);
        surf(XVector,YVector,U(:,:,1));
        zlim([0.5,2]);
        drawnow
        R(i/modOP) = getframe;
    end
end

% disp('Press a Key');
% w = waitforbuttonpress;
% movie(R);

% M02 End Program