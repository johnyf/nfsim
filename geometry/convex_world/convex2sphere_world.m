% File:      convex2sphere_world.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2010.09.25
% Language:  MATLAB, program version: 7.11 (2010b)
% Purpose:   take real world, return sphere world
% Copyright: Ioannis Filippidis, 2010-

function [xi, ri] = convex2sphere_world(world, known_world)
xi = [];
ri = [];

id = known_world.id;
n = size(id, 2);

% no obstacles
if n == 0
    return
end

obstacles = world.obstacles;
details = known_world.details;

[xcenter_temp, ~, ~, ~] = find_circle_within(obstacles{1, 1}, details{1, 1});
ndim = size(xcenter_temp, 1);

xi = zeros(ndim, n);
ri = zeros(1, n);
%e = zeros(1,n);

% select centers & circles
for i=1:n
   curid = id(1, i);
   
   obs = obstacles{curid, 1};
   
   obs_details = details{1, i};
   
   [xcenter_temp, r_temp, e_temp, ~] = find_circle_within(obs, obs_details);
   
   xi(:,i) = xcenter_temp;
   ri(1,i) = r_temp;
   
   %e(1,i) = e_temp; % with this option it is not needed to check if we
   % are within an obstacle's effect disk in the sphere world when not
   % in a weighted Voronoi cell. But this renders the navigation
   % function too steep near the obstacles.
end
