function [] = test_twin_circles
%
% See also BETA_TWIN_CIRCLES, PLOT_TWIN_CIRCLES, PARAMETRIC_TWIN_CIRCLES.
%
% File:      test_twin_circles.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.05.22
% Language:  MATLAB R2012a
% Purpose:   test twin circles parametric & implicit functions
% Copyright: Ioannis Filippidis, 2012-

clf

%% default
%lemniscate_booth
ax = gca;

%% with args
xc = 0.5;
rho = 1;

qc = [xc, 0].';
plot_twin_circles(ax, qc, rho, 'r--');

%% beta
dom = [-2, 2, -2, 2];
res = [250, 300];

[q, X, Y] = domain2vec(dom, res);

bi = beta_twin_circles(q, qc, rho);

Bi = vec2meshgrid(bi, X);

hold(ax, 'on')
contour(ax, X, Y, Bi, linspace(-0.3, 3, 30) )
axis(ax, 'equal')
