function [] = point_world_transformation
% File:      point_world_transformation.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.05.04
% Language:  MATLAB R2012a
% Purpose:   switch function used by Loizou for retraction to point world
% Copyright: Ioannis Filippidis, 2012-

% parameters adapted a bit than those in the ACC'12 paper
x = linspace(0, 3, 1000);
d = 2;

y = sigma1(x, d) -0.5;

ax = newax;
hold(ax, 'on')
plot(ax, x, y, 'b-')
plot(ax, x, x, 'r--')
axis(ax, 'image')
grid(ax, 'on')

function [s1] = sigma1(x, d)

x = x -0.5;

c = eta(x, d);
s1 = x ./d .*(1 +c) +c;

function [y] = eta(x, d)
a = s(x);
b = s(d -x);
y = a ./(a +b);

function [y] = s(x)
y = exp(-1 ./x);
y(x <= 0) = 0;
