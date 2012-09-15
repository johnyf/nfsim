function [] = ellipsoid_focal_surface
% See also TORUS_FOCAL_SURFACE, PLOT_BETA_FOCAL_SURFACES.

obstacles = init_complicated_obstacles_3d(gca, 10);
ellipsoid = obstacles(1).data(1);

ax = gca;
axis(ax, 'on')
cla(ax)
hold(ax, 'on')

npnt = 25;
[q, X, ~, ~] = plot_ellipsoids(ax, ellipsoid, npnt);
res = size(X);

obstacles = [];
obstacles.type = 'ellipsoids';
obstacles.data = ellipsoid;

% caution
%   focal surfaces for one obstacle on its surface are ok

plot_beta_focal_surfaces(ax, q, res, obstacles)
grid(ax, 'on')
axis(ax, 'image')
