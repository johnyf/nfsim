function [] = plot_trajectory(ax, x0, xtraj, xd, x0str, xdstr,...
                              xtraj_style, x0_style, xd_style, n_subsample)
%PLOT_TRAJECTORY    Plot trajectory in space.
%
% usage
%   plot_trajectory(ax, x0, xtraj, xd, x0str, xdstr)
%   plot_trajectory(ax, x0, xtraj, xd, x0str, xdstr, xtraj_style, x0_style, xd_style, n_subsample)
%
% input
%   ax = axes object handle
%   x0 = initial point(s)
%      = [#dim x #traj]
%   xtraj = intermediate trajectory points
%         = [#dim x #pnts] |
%           {1 x #traj} = {[#dim x #pnt1], [#dim x #pnt2], ... }
%   xd = destination point(s)
%      = [#dim x #traj]
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
%   n_subsample = use at most this number of points per trajectory
%                 (economizes on file size)
%               >0 (default=100) | =0 (disable)
%
% caution
%   if subsampling, all trajectories should have same number of points
%
% See also plot_path, test_plot_traj.
%
% File:      plot_trajectory.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.01.02 - 2012.09.20
% Language:  MATLAB R2012a
% Purpose:   plot trajectory followed by the system, initial condition and
%            desired destination
% Copyright: Ioannis Filippidis, 2012-

% depends
%   plotmd, textmd, takehold, restorehold

% todo
%   update code of: nf_spline_plot_results, nf_spline_plot_results_md, plotq0qsqd
%   to use this for multiple trajectories

%% input
% single traj ?
if ~iscell(xtraj)
    xtraj = {xtraj};
end

if nargin < 7
    xtraj_style = {'Color', 'b', 'LineWidth', 2};
end

if nargin < 8
    x0_style = {'Color', 'r', 'Marker', 's', 'LineStyle', 'none'};
end

if ~ismember('LineStyle', x0_style)
    x0_style = [x0_style, {'LineStyle', 'none'} ];
end

if nargin < 9
    xd_style = {'Color', 'g', 'Marker', 'o', 'LineStyle', 'none'};
end

if ~ismember('LineStyle', xd_style)
    xd_style = [xd_style, {'LineStyle', 'none'} ];
end

if nargin < 10
    n_subsample = 100;
end

held = takehold(ax);

%% data
% subsample
npnt = size(xtraj{1, 1}, 2);
if (npnt > n_subsample) && (n_subsample ~= 0)
    idx = linspace(1, npnt, 100);
    idx = fix(idx);
    xtraj = cellfun(@(x) x(:, idx), xtraj, 'UniformOutput', false);
end

% concatenate multiple lines, separated by NaN columns
ndim = size(xtraj{1, 1}, 1);
sep = nan(ndim, 1);
xt = cellfun(@(x) [x, sep], xtraj, 'UniformOutput', false);
xt = cell2mat(xt);

% get actual end-points
xfinal = cellfun(@(x) x(:, end), xtraj, 'UniformOutput', false);
xfinal = cell2mat(xfinal);

%% plot
plotmd(ax, xt, xtraj_style{:} ) % trajectory
% note
%   no HandleVisibility off needed, since concatenated into single line object
plotmd(ax, x0, x0_style{:} ) % initial condition
plotmd(ax, xfinal, 'Color', 'r', 'Marker', 'o', 'LineStyle', 'None', 'HandleVisibility','off') % actual final point
plotmd(ax, xd, xd_style{:} ) % desired destination

% txt annotations
%{
% not nice result
n0 = size(x0, 2);
for i=1:n0
    curx0 = x0(:, i);
    
    textmd(1.1 *curx0, x0str, 'Interpreter', 'Latex', 'FontSize', 15, 'Parent', ax) % initial condition
end

nd = size(xd, 2);
for i=1:nd
    curxd = xd(:, i);
    
    textmd(1.1 *curxd, xdstr, 'Interpreter', 'Latex', 'FontSize', 15, 'Parent', ax) % desired destination
end
%}

curx0 = x0(:, 1);
curxd = xd(:, 1);

textmd(1.1 *curx0, x0str, 'Interpreter', 'Latex', 'FontSize', 15, 'Parent', ax) % initial condition
textmd(1.1 *curxd, xdstr, 'Interpreter', 'Latex', 'FontSize', 15, 'Parent', ax) % desired destination

restorehold(ax, held)
