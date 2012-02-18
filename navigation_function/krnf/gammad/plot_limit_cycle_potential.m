function [] = plot_limit_cycle_potential
% File:      plot_limit_cycle_potential.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.12.26
% Language:  MATLAB R2011b
% Purpose:   plot Palis degenerate potential field with limit cycle
% Copyright: Ioannis Filippidis, 2011-

x = linspace(-2, 2, 100);
y = linspace(-2, 2, 100);

[X, Y] = meshgrid(x, y);

Z = limit_cycle_potential(X, Y);

surf(X, Y, Z)
