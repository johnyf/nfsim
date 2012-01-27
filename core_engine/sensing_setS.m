function [sensed] = sensing_setS(agent, world)
% File:         sensing_setS.m
% Author:       Ioannis Filippidis, jfilippidis@gmail.com
% Date:         2010.09.12 - 
% Language:     MATLAB R2010b
% Purpose:      sense, assuming all obstacles are spheres
% Copyright:    Ioannis Filippidis, 2010-

x = agent.xcur;
Rs = agent.Rs;
obstacles = world.obstacles;

% init
sensed.id = [];
sensed.details = {};

% all obstacles (0,...,M)
obs_count = 0;
for i=1:size(obstacles,1)
    obs = obstacles{i,1};
    
    % sphere?
    if obs.type ~= 2
        continue
    end
    
    % within range?
    dist = abs(norm(x -obs.xobs, 2) - abs(obs.robs) );
    if dist < Rs
        obs_count = obs_count +1;
        sensed.id(1, obs_count) = i; % number of sensed obstacle
        sensed.details{1, obs_count} = -1; % not implemented for spheres
    end
end
