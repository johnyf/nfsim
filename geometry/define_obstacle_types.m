function [types] = define_obstacle_types
%DEFINE_OBSTACLE_TYPES  Names of obstacle types.
%
% See also PLOT_HETEROGENOUS_OBSTACLES.
%
% File:      define_obstacle_types.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.05.25
% Language:  MATLAB R2012a
% Purpose:   define names for obstacle types (plural)
% Copyright: Ioannis Filippidis, 2012-

types = {'ellipsoids', 'not_ellipsoids',...
         'tori', 'superellipsoids',...
         'supertoroids', 'halfspaces', 'cylinders',...
         'booth_lemniscates', 'inward_booth_lemniscates',...
         'visibility_lemniscates', 'visibility_angle_obstacles'};
