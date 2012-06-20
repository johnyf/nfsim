function [] = ellipsoid_focal_surface
% See also TORUS_FOCAL_SURFACE, PLOT_BETA_FOCAL_SURFACES.

obstacles = init_complicated_obstacles_3d(gca, 10);
ellipsoid = obstacles(1).data(1);

%ellipsoid.A = eye(3);

ax = gca;

axis(ax, 'on')

npnt = 50;
[q, X, ~, ~] = plot_ellipsoids(ax, ellipsoid, npnt);

obstacles = [];
obstacles.type = 'ellipsoids';
obstacles.data = ellipsoid;

% caution
%   focal surfaces for one obstacle on its surface are ok
%   focal surfaces 

hold(ax, 'on')
plot_beta_focal_surfaces(ax, q, X, obstacles)
grid(ax, 'on')
axis(ax, 'image')
