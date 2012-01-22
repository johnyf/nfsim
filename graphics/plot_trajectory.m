function [] = plot_trajectory(ax, x0, xtraj, xd, varargin)
%
% [] = plot_trajectory(ax, x0, xtraj, xd, varargin)
%
% File:      plot_trajectory.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.01.02 - 2012.01.22
% Language:  MATLAB R2011b
% Purpose:   plot trajectory followed by the system, initial condition and
%            desired destination
% Copyright: Ioannis Filippidis, 2012-

%% trajectory
plotmd(ax, xtraj, varargin{:} )

%% initial condition
plotmd(ax, x0(:, 1), 'rs')
text(x0(1,1)+0.1, x0(2,1)+0.1, '$q_0$',...
    'Interpreter', 'Latex', 'FontSize', 15, 'Parent', ax)

%% desired destination
plotmd(ax, xd(:, 1), 'go')
text(xd(1,1)+0.1, xd(2,1)+0.1, '$q_d$',...
    'Interpreter', 'Latex', 'FontSize', 15, 'Parent', ax)
