function [] = plot_transformation
% File:      plot_transformation.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2010.09.18 - 2012.02.22
% Language:  MATLAB R2010b
% Purpose:   plot example diffeomorphism
% Copyright: Ioannis Filippidis, 2010-

%% init obstacles - real world
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

fig = figure;
ax = subplot(1, 2, 1, 'Parent', fig);
npnt = 35;
held = takehold(ax);
plot_heterogenous_obstacles(ax, obstacles, npnt)
axis(ax, 'image')
axis(ax, 'off')

%% init model sphere world
qi = [0, 0; 2, 1].';
ri = [5, 15];

%% grid of points
domain = [-6, 10, -5, 10];
res = [50, 50];
[q, X, Y, Z] = domain2vec(domain, res);

bi = beta_heterogenous(q, obstacles);
b = bi2b(bi);
inward = find_inward_obstacles(obstacles);

q(:, b <= 0) = nan;
lambda = 1;
qmodel = star_world_transformation(q, b, bi, qi, ri, inward, lambda);

[Xmodel, Ymodel] = vec2meshgrid(qmodel, X);
Zmodel = Z;
Zmodel(isnan(Xmodel) ) = nan;

[X, Y] = vec2meshgrid(q, X);
Z(isnan(Xmodel) ) = nan;
mesh(ax, X, Y, Z, 'LineWidth', 1.1, 'EdgeColor', 'green');

ax = subplot(1, 2, 2, 'Parent', fig);
mesh(ax, Xmodel, Ymodel, Zmodel, 'LineWidth', 1.1, 'EdgeColor', 'red')
view(ax, 2)
axis(ax, 'image')
axis(ax, 'off')
