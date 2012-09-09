function [] = img_on_hyperboloid
% File:      img_on_hyperboloid.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.05.03 - 
% Language:  MATLAB R2010b
% Purpose:   embed an image in a one-sheet hyperboloid
% Copyright: Ioannis Filippidis, 2011-

%% Load the image
C = imread('img.jpg');
C = double(C) /100;

%% Parameterize the surface
theta = linspace(0,2*pi,size(C,2)+1);
z = linspace(2,-2,size(C,1)+1);
[Theta,Z] = meshgrid(theta,z);
R = sqrt(1 + Z.^2);
X = R.*cos(Theta);
Y = R.*sin(Theta);

%% Plot (and color) the surface
surf(X,Y,Z,C, 'LineStyle', 'none')
set(gca, 'Visible', 'off')
daspect([1 1 1])
light
