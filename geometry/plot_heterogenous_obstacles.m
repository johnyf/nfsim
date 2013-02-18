function [] = plot_heterogenous_obstacles(ax, obstacles, npnt, varargin)
%PLOT_HETEROGENOUS_OBSTACLES    Plot mixed obstacle types.
%
% usage
%   PLOT_HETEROGENOUS_OBSTACLES(ax, obstacles)
%   PLOT_HETEROGENOUS_OBSTACLES(ax, obstacles, npnt)
%
% input
%   ax = axes handle
%   obstacles = array of obstacle definitions
%   npnt = number of points on obstacles
%
% note
%   To add new obstacle types, update function define_obstacle_types.
%   The function should be of the form:
%       plot_names(ax, data, npnt)
%   where:
%       'names' = plural of obstacle type, e.g. 'ellipsoids', 'tori', etc.
%       ax = axes handle
%       data = structure with parameter arrays as fields
%       npnt = number of points on obstacles
%
% See also CREATE_HETEROGENOUS_OBSTACLES, BETA_HETEROGENOUS,
%          DEFINE_OBSTACLE_TYPES.
%
% File:      plot_heterogenous_obstacles.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2010.09.13 - 2012.05.25
% Language:  MATLAB R2012a
% Purpose:   Plot mized types of obstacles
% Copyright: Ioannis Filippidis, 2010-

% depends
%   define_obstacle_types, takehold, restorehold

%todo: implement opacity for inward obstacles

%% input

if (nargin >= 1) && any(~ishandle(ax) )
    error('ax is not an axes object handle.')
end

% obstacles ?
if nargin < 2
    warning('nfsim:plot:NoObstacles', 'No obstacles provided.')
    return
end

if isempty(obstacles)
    warning('nfsim:plot:NoObstacles', 'Empty OBSTACLES array.')
    return
end

if isempty(ax)
    ax = gca;
end

if nargin < 3
    npnt = 35;
end

%% prep
nobstacle_types = size(obstacles, 2);
types = define_obstacle_types;

%% plot
held = takehold(ax, 'local');
for i=1:nobstacle_types
    type = obstacles(1, i).type;
    data = obstacles(1, i).data;
    fname = ['plot_', type];
    
    switch type
        case types
            feval(fname, ax, data, npnt, varargin{:} );
        case 'spheres'
            %plot_circle(ax, xc, r, col, center_style, '-');
            %plotSphere(ax, xc, r, 'Color', col, 'Opacity', opacity);
        case 'bezier2d'
            %plot_visible_bezier_obstacle(ax, part_shown)
        otherwise
            feval(fname, ax, data, npnt, varargin{:} );
            warning('nfsim:ObstaclePlot:UnknownType',...
                    ['Unknown obstacle type: ', type] )
    end
end
restorehold(ax, held)
