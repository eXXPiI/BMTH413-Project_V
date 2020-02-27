%% Preamble
% Program: CalculateDiffusion.m
% Author: Jonathan Myers
% Date: February 24, 2020
% Purpose: Simulate diffusion of calcium particles.
% Arguments: None.
% Loads: None.
% Calls: None.
% Returns: None.

%% Start
function newChange = CalculateDiffusion(U,D,deltaTime,delX,delY,old)
space = U(:,:,old);
% delXAdd = [space(:,2:end),zeros(size(space,1),1)];
% delXSubtract = [zeros(size(space,1),1),space(:,1:end-1)];
% delYAdd = [space(2:end,:);zeros(1,size(space,2))];
% delYSubtract = [zeros(1,size(space,2));space(1:end-1,:)];

delXAdd = [space(:,2:end),space(:,end)];
delXSubtract = [space(:,end-1),space(:,1:end-1)];
delYAdd = [space(2:end,:);space(end,:)];
delYSubtract = [space(end-1,:);space(1:end-1,:)];

delY2Term = delXAdd - 2*space + delXSubtract;
delX2Term = delYAdd - 2*space + delYSubtract;
factor = (D*deltaTime)/((delX^2)*(delY^2));
newChange = space + factor*((delY2Term*delY^2)+(delX2Term*delX^2));

% M02 End Program