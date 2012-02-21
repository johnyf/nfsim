function [isinward] = find_inward_obstacles(obstacles)
%
% output
%   isinward = [#obstacles x 1];
%
% File:      find_inward_obstacles.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.02.21
% Language:  MATLAB R2011b
% Purpose:   find which obstacles are inward obstacles
% Copyright: Ioannis Filippidis, 2011-

nobstacle_types = size(obstacles, 2);
nobstacles = 0;
for i=1:nobstacle_types
    type = obstacles(1, i).type;
    data = obstacles(1, i).data;
    
    n_this_obs_type = size(data, 1);
    idx = [nobstacles+1: nobstacles+n_this_obs_type];
    nobstacles = nobstacles +n_this_obs_type;
    
    if strcmp(type, 'inward_quadrics')
        isinward(idx, 1) = 1;
    else
        isinward(idx, 1) = 0;
    end
end
