function [h, q] = plot_lemniscate_booth(ax, qc, a, r0, npnt, coor, varargin)
%PLOT_LEMNISCATE_BOOTH   Booth leminiscate curve and plot.
%   PLOT_LEMNISCATE_BOOTH(ax, a, r0, coor) plots the lemniscate of Booth.
%   The difference with plot_lemniscate_booth2 is that here the lemniscate
%   parameters are the shape ratio a and the scale r0.
%
% usage
%   [x1, x2] = PLOT_LEMNISCATE_BOOTH
%   [x1, x2] = PLOT_LEMNISCATE_BOOTH(ax, a, r0, coor, varargin)
%
% optional input
%   ax = axes object handle
%   qc = lemniscate center coordinates vector
%      = [2 x 1] = [xc, yc].'
%   a = leminiscate axis ratio
%     > 0
%   r0 = leminiscate scale
%      > 0
%   npnt = number of grid points to use
%   coor = output coordinate system
%        = 'cartesian' | 'polar'
%   varargin = options passed to plot
%
% output
%   x1 = first coordinate of curve points
%      = x (if coor == 'cartesian') | theta (if coor == 'polar')
%   x2 = second coordinate of curve points
%      = y (if coor == 'cartesian') | r (if coor == 'polar')
%
% See also PLOT_LEMNISCATE_BOOTH2, BETA_LEMNISCATE_BOOTH,
%          PARAMETRIC_LEMNISCATE_BOOTH2, PARAMETRIC_LEMNISCATE_BOOTH,
%          TEST_LEMNISCATE_BOOTH.
%
% File:      plot_lemniscate_booth.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.05.21
% Language:  MATLAB R2012a
% Purpose:   parametric Booth Leminiscate curve and plot
% Copyright: Ioannis Filippidis, 2012-

% depends
%   parametric_lemniscate_booth

%% input
if nargin < 1
    ax = gca;
end

if nargin < 2
    qc = origin(2);
end

if nargin < 3
    a = 0.8;
end

if nargin < 4
    r0 = 1;
end

if nargin < 5
    npnt = 35;
end

if (nargin < 6) || (nargout < 2)
    coor = 'cartesian';
end

%% calc
theta = linspace(0, 2*pi, npnt);

r = parametric_lemniscate_booth(theta, a, r0);

%% plot
q = local_pol2global_cart(theta, r, qc);
h = plotmd(ax, q, varargin{:} );

%% output
if nargout == 0
    clear('h')
end

if strcmp(coor, 'polar')
    q = [theta, r];
end
