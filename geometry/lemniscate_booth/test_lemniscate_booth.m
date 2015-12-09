function [] = test_lemniscate_booth
%TEST_LEMNISCATE_BOOTH  Testing plots for Booth Leminiscate.
%
% See also PLOT_LEMNISCATE_BOOTH, BETA_LEMNISCATE_BOOTH,
%          PARAMETRIC_LEMNISCATE_BOOTH.
%
% File:      test_lemniscate_booth.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.05.21
% Language:  MATLAB R2012a
% Purpose:   test parametric Booth Leminiscate plot and obstacle function
% Copyright: Ioannis Filippidis, 2012-

clf

%% default
%lemniscate_booth
ax = gca;

%% with args

a = 1;
r0 = 1;
coor = 'cartesian';
[x, y] = plot_lemniscate_booth(ax, a, r0, coor);

plot(ax, x, y, 'r--')

%% beta
dom = [-2, 2, -2, 2];
res = [250, 300];

[q, X, Y] = domain2vec(dom, res);

bi = beta_lemniscate_booth(q, origin(2), a, r0, eye(2) );

Bi = vec2meshgrid(bi, X);

hold(ax, 'on')
contour(ax, X, Y, Bi, linspace(-0.3, 0.2, 30) )
axis(ax, 'equal')
