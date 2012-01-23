function [] = plot_trajectory(ax, x0, xtraj, xd, x0str, xdstr, varargin)
%PLOT_TRAJECTORY    plot initial, intermediate, destination points
%
% [] = plot_trajectory(ax, x0, xtraj, xd, '$q_0$', '$q_d$', 'r-')
%
% input
%   ax = axes handle
%   x0 = initial point
%      = [#dim x 1]
%   xtraj = intermediate trajectory points
%         = [#dim x #pnts]
%   xd = destination point
%      = [#dim x 1]
%   varargin = plot formatting arguments for intermediate points
%       e.g. = 'r-o'
%
% File:      plot_trajectory.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.01.02 - 2012.01.22
% Language:  MATLAB R2011b
% Purpose:   plot trajectory followed by the system, initial condition and
%            desired destination
% Copyright: Ioannis Filippidis, 2012-

held = applyhold(ax);

%% trajectory
plotmd(ax, xtraj, varargin{:} )

%% initial condition
plotmd(ax, x0, 'Color', 'r', 'Marker', 's')
textmd(1.1 *x0, x0str, 'Interpreter', 'Latex', 'FontSize', 15, 'Parent', ax)

%% actual final trajectory point
plotmd(ax, xtraj(:, end), 'Color', 'r', 'Marker', 'o', 'HandleVisibility','off') % maybe separate it

%% desired destination
plotmd(ax, xd, 'Color', 'g', 'Marker', 'o')
textmd(1.1 *xd, xdstr, 'Interpreter', 'Latex', 'FontSize', 15, 'Parent', ax)

holdback(ax, held)
