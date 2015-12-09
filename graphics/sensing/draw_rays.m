function [] = draw_rays(ax, x, xb)
%DRAW_RAYS  plot rays from X to endpoints of XB
%
% usage
%   [] = DRAW_RAYS(AX, X, XB)
%
% input
%   ax = axes handle
%   x = current point from which to draw rays
%     = [#dim x 1]
%   xb = sensed points
%      = [#dim x #(sensed pnts) ]
%
% See also DRAW_SENSING_SET.
%
% File:      draw_rays.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2010.09.15 - 2012.01.22
% Language:  MATLAB R2011b
% Purpose:   plot sensing rays to endpoints of visible obstacle boundary
% Copyright: Ioannis Filippidis, 2010-

% vectors from x to endpoints
ray1(:, 1) = xb(:, 1) -x;
ray2(:, 1) = xb(:, end) -x;

ray1 = Rs *normvec(ray1);
ray2 = Rs *normvec(ray2);

% draw stationed ray vectors
draw_ray(ax, x, ray1)
draw_ray(ax, x, ray2)

function [] = draw_ray(ax, x, ray)
x2 = x +ray;
v = [x, x2];
plotmd(ax, v, 'Color', 'r')
