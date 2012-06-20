function [] = plot_path(ax, x0, xtraj, xd, x0str, xdstr, zoff, zonsurf, Rs)
%PLOT_PATH  Plot trajectory on function surface.
%
% usage
%   PLOT_PATH(ax, x0, xtraj, xd)
%   PLOT_PATH(ax, x0, xtraj, xd, x0str, xdstr, zoff, zonsurf, Rs)
%
% input
%   ax = axes object handle
%   x0 = initial condition
%   xtraj = path subsequent points
%   xd = agent destination
%   x0str = initial condition text annotation
%         = string
%   xdstr = destination text annotation
%         = string
%   zoff = the contour plot level z offset
%        = real | []
%   zonsurf = navigation function values at corresponding points
%           = [1 x size(xtraj, 2) ] | []
%   Rs = sensing radius
%      > 0 | []
%
% See also PLOT_TRAJECTORY.
%
% File:      plot_path.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2010.09.20 - 2012.01.22
% Language:  MATLAB R2011b
% Purpose:   plot 2/3D path (in 2D can also be shown on surface)
% Copyright: Ioannis Filippidis, 2010-

% depends
%   plotmd, zoffset, plot_trajectory, plot_circle, plotSphere

%% input
if nargin < 9
    Rs = [];
end

if nargin < 8
    zonsurf = [];
end

if nargin < 7
    zoff = [];
end

if nargin < 6
    xdstr = '';
end

if nargin < 5
    x0str = '';
end

ndim = size(x0, 1);

%% plot
held = takehold(ax);

if ndim == 2
    % vertical offset ?
    if ~isempty(zoff)
        x0 = zoffset(x0, zoff);
        xtraj = zoffset(xtraj, zoff);
        xd = zoffset(xd, zoff);
    end
    
    % 3D path (imagined on field surface)
    if ~isempty(zonsurf)
        xonsurf = zoffset(xtraj, zonsurf);
        plotmd(ax, xonsurf, 'Linewidth', 3, 'Color', 'm', 'Linestyle', '-')
    end
end

plot_trajectory(ax, x0, xtraj, xd, x0str, xdstr,...
                {'Linewidth', 2, 'Color', 'r', 'Linestyle', '-'} )

%% sensing on ?
if ~isempty(Rs)
    if ndim == 2
        plot_circle(ax, xtraj(:, end), Rs, 'r', 'Color', 'm', 'LineStyle', '--',...
            'CenterStyle', 'mo')
    elseif ndim == 3
        plotSphere(ax, xtraj(:, end), Rs, 'Color', 'r', 'Opacity', 0);
    else
        error('Path plot only available for 2 and 3 dimensions.')
    end
end

restorehold(ax, held)
