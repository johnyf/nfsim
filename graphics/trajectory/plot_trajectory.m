function [] = plot_trajectory(ax, xtraj, x0, xd, x0str, xdstr,...
                              xtraj_style, x0_style, xd_style, n_subsample)
%PLOT_TRAJECTORY    Plot trajectory, initial condition and
%                   desired destination.
%
% usage
%   PLOT_TRAJECTORY(ax, xtraj)
%   PLOT_TRAJECTORY(ax, xtraj, x0, xd, x0str, xdstr,...
%                       xtraj_style, x0_style, xd_style, n_subsample)
%
% input
%   ax = axes object handle
%   xtraj = intermediate trajectory points
%         = [#dim x #pnts] |
%           {1 x #traj} = {[#dim x #pnt1], [#dim x #pnt2], ... }
%
% optional input
%   x0 = initial point(s) [xtraj
%      = [#dim x #traj]
%   xd = destination point(s) [none]
%      = [#dim x #traj]
%   x0str = initial condition text annotation ['$x_0$']
%         = string
%   xdstr = destination text annotation ['$x_0$']
%         = string
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
% 2012.01.02 - 2013.02.04 (c) Ioannis Filippidis, jfilippidis@gmail.com
%
% See also plot_path, test_plot_traj.

% depends
%   plotmd, textmd, takehold, restorehold, subsample

% todo
%   update code of: nf_spline_plot_results, nf_spline_plot_results_md, plotq0qsqd
%   to use this for multiple trajectories

%% input
% single traj ?
if ~iscell(xtraj)
    xtraj = {xtraj};
end

if nargin < 3
    x0 = []; % will be extracted later based on this "flag"
elseif iscell(x0) % temporary compatibility check
    error('update your code, plot_trajectory changed order of args 2,3')
end

if (size(x0, 2) > 1) && (length(xtraj) == 1)
    error('Multiple x0, one xtraj, check order of args 2,3.')
end

if nargin < 4
    xd = [];
end

if nargin < 5
    x0str = '$x_0$';
end

if nargin < 6
    xdstr = '$x_d$';
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
    ddisp('No subsampling for plot_trajectory, using: n = 100.')
    n_subsample = 100;
end

held = takehold(ax);

%% data
% subsample
npnt = size(xtraj{1, 1}, 2);
if (npnt > n_subsample) && (n_subsample ~= 0)
    xtraj = cellfun(@subsample, xtraj, 'UniformOutput', false);
end

% concatenate multiple lines, separated by NaN columns
ndim = size(xtraj{1, 1}, 1);
sep = nan(ndim, 1);
xt = cellfun(@(x) [x, sep], xtraj, 'UniformOutput', false);
xt = cell2mat(xt);

% get actual start-points (if none provided)
if isempty(x0)
    x0 = cellfun(@(x) x(:, 1), xtraj, 'UniformOutput', false);
    x0 = cell2mat(x0);
end

% get actual end-points
xfinal = cellfun(@(x) x(:, end), xtraj, 'UniformOutput', false);
xfinal = cell2mat(xfinal);

%% plot
plotmd(ax, xt, xtraj_style{:} ) % trajectory
% note
%   no HandleVisibility off needed, since concatenated into single line object
plotmd(ax, x0, x0_style{:} ) % initial condition
plotmd(ax, xfinal, 'Color', 'b', 'Marker', 'o', 'LineStyle', 'None',...
                   'HandleVisibility','off') % actual final point

% no destination ?
if ~isempty(xd)
    plotmd(ax, xd, xd_style{:} ) % desired destination
end

% annotate only single initial condition and desired destination
if ~isempty(xd)
    annot_x0_xd(ax, x0(:, 1), x0str, xd(:, 1), xdstr)
else
    annot_x0_xd(ax, x0(:, 1), x0str, [], xdstr)
end

% not nice result to annotate all initial conditions
%annot_x0_xd(ax, x0, x0str, xd, xdstr)

restorehold(ax, held)

function [] = annot_x0_xd(ax, x0, x0str, xd, xdstr)
% annotate initial conditions
n0 = size(x0, 2);
for i=1:n0
    curx0 = x0(:, i);
    textmd(1.1 *curx0, x0str, 'Interpreter', 'Latex', 'FontSize', 15, 'Parent', ax)
end

% no destination ?
if isempty(xd)
    return
end

% annotate desired destinations
nd = size(xd, 2);
for i=1:nd
    curxd = xd(:, i);
    textmd(1.1 *curxd, xdstr, 'Interpreter', 'Latex', 'FontSize', 15, 'Parent', ax)
end
