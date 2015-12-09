function [] = plot_mapping(figax, q, qmodel, resolution)
%PLOT_MAPPING   Plot a diffeomorphism on XY plane.
%
% usage
%   PLOT_MAPPING(figax, q, qmodel, resolution)
%
% input
%   figax = handle to 1 figure object or 2 figure/axes objects
%   q = mesh points in original world
%   qmodel = mesh points after the mapping
%   X = meshgrid matrix of x coordinates (to get the size)
%   Z = meshgrid matrix of z coordinates (flat = 0)
%
% See also SAMPLE_ELLIPSE_WORLD_2_SPHERE_WORLD.
%
% File:      plot_mapping.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.05.21
% Language:  MATLAB R2012a
% Purpose:   plot a mapping E^2-> E^2 using grids
% Copyright: Ioannis Filippidis, 2012-

% depends
%   res2meshsize, vec2meshgrid, takehold, restorehold

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

resolution = res2meshsize(resolution);
Z = zeros(resolution);

%% prep
[Xmodel, Ymodel] = vec2meshgrid(qmodel, [], resolution);
Zmodel = Z;
Zmodel(isnan(Xmodel) ) = nan;

[X, Y] = vec2meshgrid(q, [], resolution);
Z(isnan(Xmodel) ) = nan;

%% plot
held = takehold(ax1, 'local');

mesh(ax1, X, Y, Z, 'LineWidth', 1.1, 'EdgeColor', 'green');

axis(ax1, 'image')
restorehold(ax1, held)

held = takehold(ax2, 'local');

mesh(ax2, Xmodel, Ymodel, Zmodel, 'LineWidth', 1.1, 'EdgeColor', 'red')

view(ax2, 2)
axis(ax2, 'image')
restorehold(ax2, held)
