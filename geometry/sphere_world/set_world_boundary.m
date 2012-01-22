% File:      set_world_boundary.m
% Author:    Ioannis Filippidis, Mechanical Engineer, jfilippidis@gmail.com
% Date:      2010.03.09 - 
% Language:  MATLAB, program version: 7.11 (2010b)
% Purpose:   change sphere world world boundary
% Copyright: Ioannis Filippidis, 2011-

function [world] = set_world_boundary(world, q0, r0)
obstacles = world.obstacles;

M = size(obstacles, 1);

id0 = M +1;
for i=1:M
    obs = obstacles{i, 1};
    
    % sphere?
    if obs.type ~= 2
        continue;
    end
    
    % obstacle 0?
    if obs.robs > 0
        continue;
    end
    
    id0 = i;
end

obs = [];
obs.type = 2;
obs.xobs = q0;
obs.robs = -r0;

obstacles{id0, 1} = obs;
world.obstacles = obstacles;
