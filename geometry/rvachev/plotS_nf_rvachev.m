% File:      plotS_nf_rvachev.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2010.11.11 - 
% Language:  MATLAB version 7.11 (2010b)
% Purpose:   Rvachev Navigation Function plot & contour in sphere world
% Copyright: Ioannis Filippidis, 2010-

cls
agent = init_agent;
world = init_sphere_world;
known_world = init_known_world(1, 9);
plotS_nf_and_contour(agent, world, known_world, 'nf_rvachev')
