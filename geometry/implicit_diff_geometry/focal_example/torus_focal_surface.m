function [] = torus_focal_surface
%
% See also ELLIPSOID_FOCAL_SURFACE, PLOT_BETA_FOCAL_SURFACES.

obstacles = torus_lower_right;

ax = gca;
axis(ax, 'on')
grid(ax, 'on')
hold(ax, 'on')

npnt = 30;
[q, res] = parametric_torus2(obstacles(1).data, npnt);

plot_beta_focal_surfaces(ax, q, res, obstacles)
axis(ax, 'image')
