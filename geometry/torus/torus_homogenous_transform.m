function [] = torus_homogenous_transform
% File:      torus_homogenous_transform.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.09.13
% Language:  MATLAB R2011a
% Purpose:   Homogenous transform of torus frame (fig in Diploma thesis)
% Copyright: Ioannis Filippidis, 2011-

fig = figure;
ax = axes('Parent', fig);
hold(ax, 'on')
grid(ax, 'on')

plot_torus(ax, zeros(3,1), 1, 3, eye(3), 50)
plot_torus(ax,[8, 3, 1].', 1, 3, rotx(pi/5) *roty(pi/6), 50)

plot_scalings(ax, 0)
axis(ax, 'equal')

tex_plot_annot(ax, [], '$x$', '$y$', '$z$', []);
