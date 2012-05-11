function [] = mobius_band
% File:      mobius_band.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.04.26
% Language:  MATLAB R2012a
% Purpose:   plot Mobius Strip embedded in E^3
% Copyright: Ioannis Filippidis, 2010-

u = linspace(-pi, pi, 100);
v = linspace(-1, 1, 10).';

x = (ones(10, 1) *cos(u)+0.5*v *cos(0.5*u).^2);
y = (ones(10, 1) *sin(u)+0.5*v *cos(0.5*u).^2);
z = 0.5 *v *sin(0.5*u);

surf(x, y, z)
axis equal
  %[xlabel,""],[ylabel,""],[legend,false],[grid,50,5],
  %[box,false],[elevation,25],[azimuth,0],
  %[palette,get_plot_option(palette,3)],
  %[gnuplot_term,svg],[gnuplot_out_file,"Moebius strip.svg"]);
