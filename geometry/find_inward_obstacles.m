function [isinward] = find_inward_obstacles(obstacles)
%FIND_INWARD_OBSTACLES  Indices of inwards ellipsoids.
%
% input
%   obstacles = structure array defined in beta_heterogenous
%
% output
%   isinward = [#obstacles x 1];
%
% See also BETA_HETEROGENOUS.
%
% File:      find_inward_obstacles.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.02.21 - 2012.05.25
% Language:  MATLAB R2012a
% Purpose:   find which obstacles are inward obstacles
% Copyright: Ioannis Filippidis, 2011-

nobstacle_types = size(obstacles, 2);
nobstacles = 0;
isinward = zeros(nobstacle_types, 1);
for i=1:nobstacle_types
    type = obstacles(1, i).type;
    data = obstacles(1, i).data;
    
    n_this_obs_type = size(data, 1);
    idx = (nobstacles +1): (nobstacles +n_this_obs_type);
    nobstacles = nobstacles +n_this_obs_type;
    
    if strcmp(type, 'inward')
        isinward(idx, 1) = 1;
    end
end
