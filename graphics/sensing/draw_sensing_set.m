function [] = draw_sensing_set(ax, x, Rs)
%DRAW_SENSING_SET   plot sensing circle with its radii
%
% usage
%   DRAW_SENSING_SET(AX, X, RS)
%
% input
%   ax = axes handle
%   x = center point = agent position
%     = [#dim x 1]
%   Rs = sensing radius
%
% See also DRAW_RAYS.
%
% File:      draw_sensing_set.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2010.09.15 - 2012.01.22
% Language:  MATLAB R2011b
% Purpose:   take sensing set definition plot sensing set & sensing rays
% Copyright: Ioannis Filippidis, 2010-

held = applyhold(ax);

% sensing disk boundary points
n = 1000;
t = 2 *pi *linspace(0, 1, n);
xsens = Rs *[sin(t); cos(t)];
xsens = bsxfun(@plus, x, xsens);

% sensing disk boundary
plotmd(ax, xsens, 'r-')

% sensing radii
X = [x(1, 1)*ones(1, n); xsens(1, :) ];
Y = [x(2, 1)*ones(1, n); xsens(2, :) ];
plot(ax, X, Y, 'r-')

holdback(ax, held)
