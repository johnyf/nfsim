function [] = sample_ellipse_world_2_sphere_world
%SAMPLE_ELLIPSE_WORLD_2_SPHERE_WORLD    Sample global implicit diffeomorphism.
%
% See also TEST_LOCAL_EXPLICIT_DIFFEO, PLOT_MAPPING.
%
% File:      sample_ellipse_world_2_sphere_world.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2010.09.18 - 2012.05.21
% Language:  MATLAB R2012a
% Purpose:   plot example diffeomorphism from ellipse world to sphere world
% Copyright: Ioannis Filippidis, 2010-

% depends
%   domain2vec, create_quadrics, create_inward_quadrics,
%   create_heterogenous_obstacles, plot_heterogenous_obstacles,
%   beta_heterogenous, beta_heterogenous, bi2b, find_inward_obstacles,
%   star_world_transformation, plot_mapping

%% init real ellipse world
xc = [0, 0].';
rot = {eye(2) };
r = {[2, 3] };

ellipses = create_quadrics(xc, rot, r);

xc = [2, 1].'; % 5, 5
rot = {eye(2) };
r = {[7, 6] }; % 5, 6

inward_ellipses = create_inward_quadrics(xc, rot, r);

obstacles = create_heterogenous_obstacles(ellipses, inward_ellipses,...
                                            [], [], [] );

%% init model sphere world
qi = [0, 0; 2, 1].';
ri = [5, 15];

%% graphics
fig = figure;
ax1 = subplot(1, 2, 1, 'Parent', fig);
    axis(ax1, 'off')
    hold(ax1, 'on')
ax2 = subplot(1, 2, 2, 'Parent', fig);
    axis(ax2, 'off')
    hold(ax2, 'on')

npnt = 35;
    plot_heterogenous_obstacles(ax1, obstacles, npnt)

%% grid of points
domain = [-6, 10, -5, 10];
res = [50, 50];

[q, X, ~, Z] = domain2vec(domain, res);

%% map
bi = beta_heterogenous(q, obstacles);
b = bi2b(bi);
inward = find_inward_obstacles(obstacles);

q(:, b <= 0) = nan;
lambda = 1;
qmodel = star_world_transformation(q, b, bi, qi, ri, inward, lambda);

%% plot
plot_mapping([ax1, ax2], q, qmodel, X, Z)
