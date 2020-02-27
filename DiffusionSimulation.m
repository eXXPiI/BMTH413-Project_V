%% Preamble
% Program: DiffusionSimulation.m
% Author: Jonathan Myers
% Date: February 20, 2020
% Purpose: Simulate diffusion of calcium particles.
% Arguments: None.
% Loads: None.
% Calls: None.
% Returns: None.

%% Setup
close all
clear
clc

%% Start
runNum = 5000;
D = 10;
numPoints = 50;
startX = 0;
endX = 1;
startY = 0;
endY = 1;
deltaX = (endX - startX)/numPoints;
deltaY = (endY - startY)/numPoints;
U = 10*rand(numPoints, numPoints, 2);
U(20:30,20:30,1) = 10;

% find deltaT:
deltaT = ((deltaX^2)*(deltaY^2))/(0.125*D);

modOP = 10;
% num = runNum/modOP;
% R(num) = struct('cdata',[],'colormap',[]);

for i = 1:runNum
    old = 1;
    newChange = CalculateDiffusion(U,D,deltaT,deltaX,deltaY,old);
    U(:,:,2) = newChange;
    
    old = 2;
    newChange = CalculateDiffusion(U,D,deltaT,deltaX,deltaY,old);
    U(:,:,1) = newChange;
    if mod(i,modOP) == 0
        surf(startX+deltaX:deltaX:endX,startY+deltaY:deltaY:endY,U(:,:,1));
        drawnow
        % R(i/modOP) = getframe;
    end
end

% disp('Press a Key');
% w = waitforbuttonpress;
% movie(R,1,1/deltaT);

% M02 End Program