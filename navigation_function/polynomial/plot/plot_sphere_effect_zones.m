% File:      plot_sphere_effect_zones.m
% Author:    Ioannis Filippidis, Mechanical Engineer, jfilippidis@gmail.com
% Date:      2010.09.29
% Language:  MATLAB, program version: 7.11 (2010b)
% Purpose:   take real world, plot spheres, effect zones, rays relating
%            given points to obstacles affecting them
% Copyright: Ioannis Filippidis, 2010-

function [] = plot_sphere_effect_zones(agent, world, known_world)
[xi, ri] = convex2sphere_world(world, known_world);
q = agent.xcur;

plotS_sphere_effect_zones(q, xi, ri);
