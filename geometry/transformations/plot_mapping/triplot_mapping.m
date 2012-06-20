function [] = triplot_mapping(figax, q, qmodel, tri)
%TRIPLOT_MAPPING   Plot a diffeomorphism on a triangulated 2d mesh.
%
% usage
%   TRIPLOT_MAPPING(figax, q, qmodel, tri)
%
% input
%   figax = handle to 1 figure object or 2 figure/axes objects
%   q = mesh points in original world
%   qmodel = mesh points after the mapping
%   tri = triangulated mesh matrix of triangles, i.e., correspondence
%         between triangle vertices and points in q and qmodel
%       = [#triangles x 3] = [id1, id2, id3; ;;; ]
%         where: id1 = column in q and qmodel of vertex No.1 of the first
%         triangle, etc.
%
% See also PLOT_MAPPING, SAMPLE_ELLIPSE_WORLD_2_SPHERE_WORLD.
%
% File:      triplot_mapping.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.05.26
% Language:  MATLAB R2012a
% Purpose:   plot a mapping E^2-> E^2 using triangulated grids
% Copyright: Ioannis Filippidis, 2012-

% depends
%   takehold, restorehold

%% input

% single fig handle ?
if length(figax) == 1
    fig = figax;
    
    type = get(figax, 'type');
    if strcmp(type, 'axes')
        error('nfsim:handles', 'Single axis handle provided, not enough.')
    end
    
    ax1 = subplot(1, 2, 1, 'Parent', fig);
    ax2 = subplot(1, 2, 2, 'Parent', fig);
elseif isempty(figax)
    error('nfsim:handles', 'Not enough handles provided.')
else
    ax1 = figax(1);
    ax2 = figax(2);
end

%% plot
held = takehold(ax1, 'local');

trimesh(tri, q(1, :), q(2, :), 'LineWidth', 1.1, 'Color', 'green', 'Parent', ax1);

axis(ax1, 'image')
restorehold(ax1, held)

held = takehold(ax2, 'local');

trimesh(tri, qmodel(1, :), qmodel(2, :), 'LineWidth', 1.1, 'Color', 'green', 'Parent', ax2);

view(ax2, 2)
axis(ax2, 'image')
restorehold(ax2, held)
