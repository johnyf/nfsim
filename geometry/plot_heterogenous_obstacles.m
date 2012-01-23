function [] = plot_heterogenous_obstacles(ax, obstacles, npnt)
%
% input
%   ax = axes handle
%   obstacles = array of obstacle definitions
%   npnt = number of points on obstacles
%
% File:      plot_heterogenous_obstacles.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2010.09.13 - 2012.01.22
% Language:  MATLAB R2011b
% Purpose:   plot world
% Copyright: Ioannis Filippidis, 2010-

%todo: implement opacity for inward obstacles which form the world boundary

if isempty(obstacles)
    warning('nfsim:empty', 'Empty OBSTACLES array.')
    return
end

nobstacle_types = size(obstacles, 2);

for i=1:nobstacle_types
    type = obstacles(1, i).type;
    data = obstacles(1, i).data;
    
    switch type
        case 'quadrics'
            quadrics = data;
            plot_ellipsoids(ax, quadrics, npnt);
        case 'inward_quadrics'
            inward_quadrics = data;
            plot_quadrics_inward(ax, inward_quadrics, npnt);
        case 'tori'
            tori = data;
            plot_tori(ax, tori, npnt);
        case 'superellipsoids'
            superellipsoids = data;
            plot_superellipsoids(ax, superellipsoids, npnt);
        case 'supertoroids'
            supertoroids = data;
            plot_supertoroids(ax, supertoroids, npnt);
        case 'halfspaces'
            halfspaces = data;
            plot_halfspaces(ax, halfspaces, npnt);
        case 'spheres'
            spheres = data;
            %{
            center_style = []; %'r+'
            xc = obs.xobs;
            r = obs.robs;
            plot_circle(ax, xc, r, col, center_style, '-');
            if r < 0
             opacity = 0;
            else
             opacity = 0;
            end
            plotSphere(ax, xc, r, 'Color', col, 'Opacity', opacity);
            %}
        case 'bezier2d'
            bezier2d = data;
            %plot_visible_bezier_obstacle(ax, part_shown)
        otherwise
            error('Unknown obstacle type.')
    end
end
