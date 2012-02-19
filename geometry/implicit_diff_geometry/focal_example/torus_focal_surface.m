function [] = torus_focal_surface
%
% See also ELLIPSOID_FOCAL_SURFACE, PLOT_BETA_FOCAL_SURFACES.

obstacles = torus_lower_right;
ax = gca;

axis(ax, 'on')

npnt = 30;
[q, X, ~, ~] = plot_tori(ax, obstacles(1).data, npnt);

plot_beta_focal_surfaces(ax, q, X, obstacles)
grid(ax, 'on')
axis(ax, 'image')
