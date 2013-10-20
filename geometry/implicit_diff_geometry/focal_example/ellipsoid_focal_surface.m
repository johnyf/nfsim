function [] = ellipsoid_focal_surface
%
% used in
%   Filippidis I.; Kyriakopoulos K.J.
%   Navigation Functions for Focally Admissible Surfaces
%   ACC 2013
%
%about
%-----
% 2012.01.29 (c) Ioannis Filippidis, jfilippidis@gmail.com
%
% See also TORUS_FOCAL_SURFACE, PLOT_BETA_FOCAL_SURFACES.

qc = [2, -3].';
rot = eye(3);
r = [2, 1.1].';

ellipsoid = create_ellipsoids(qc, {rot}, r);

ax = gca;
    %cla(ax)
    hold(ax, 'on')

npnt = 30;
[q, res] = parametric_ellipsoid2(ellipsoid, npnt);
vsurf(ax, q, 'scaled', res)

obstacles.type = 'ellipsoids';
obstacles.data = ellipsoid;

% caution
%   focal surfaces for one obstacle on its surface are ok
plot_beta_focal_surfaces(ax, q, res, obstacles)
plotidy(ax)
axis(ax, 'image')
axis(ax, 'off')
