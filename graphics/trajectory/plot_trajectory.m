function [] = plot_trajectory(ax, x0, xtraj, xd, x0str, xdstr,...
                              xtraj_style, x0_style, xd_style)
%PLOT_TRAJECTORY    Plot trajectory in space.
%
% usage
%   PLOT_TRAJECTORY(ax, x0, xtraj, xd, '$q_0$', '$q_d$')
%   PLOT_TRAJECTORY(ax, x0, xtraj, xd, {'$q_0$'}, {'$q_d$'}, {'b-'},...
%                                  {'rs'}, {'Color', 'g', 'Marker', 'o'} )
%
% input
%   ax = axes object handle
%   x0 = initial point
%      = [#dim x 1]
%   xtraj = intermediate trajectory points
%         = [#dim x #pnts]
%   xd = destination point
%      = [#dim x 1]
%   x0str = initial condition text annotation
%         = string
%   xdstr = destination text annotation
%         = string
%
% optional input
%   xtraj_style = trajectory style for plotmd function, for example:
%               = {'g-o'}
%               = {'Color', 'g', 'Marker', 'o', 'LineStyle', '-'}
%   x0_style = initial point style for plotmd function, for example:
%            = {'rs'}
%            = {'Color', 'r', 'Marker', 's'}
%   xd_style = destination point style for plotmd function, for example:
%            = {'go'}
%            = {'Color', 'g', 'Marker', 'o'}
%
% See also PLOT_PATH.
%
% File:      plot_trajectory.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.01.02 - 2012.01.22
% Language:  MATLAB R2011b
% Purpose:   plot trajectory followed by the system, initial condition and
%            desired destination
% Copyright: Ioannis Filippidis, 2012-

% depends
%   plotmd, textmd, takehold, restorehold

%% arguments
if nargin < 7
    xtraj_style = {'Color', 'b', 'LineWidth', 2};
end

if nargin < 8
    x0_style = {'Color', 'r', 'Marker', 's'};
end

if nargin < 9
    xd_style = {'Color', 'g', 'Marker', 'o'};
end

held = takehold(ax);

%% trajectory
plotmd(ax, xtraj, xtraj_style{:} )

%% initial condition
plotmd(ax, x0, x0_style{:} )
textmd(1.1 *x0, x0str, 'Interpreter', 'Latex', 'FontSize', 15, 'Parent', ax)

%% actual final trajectory point
plotmd(ax, xtraj(:, end), 'Color', 'r', 'Marker', 'o', 'HandleVisibility','off') % maybe separate it

%% desired destination
plotmd(ax, xd, xd_style{:} )
textmd(1.1 *xd, xdstr, 'Interpreter', 'Latex', 'FontSize', 15, 'Parent', ax)

restorehold(ax, held)
