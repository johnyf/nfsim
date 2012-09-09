function [] = plot_not_ellipsoids(ax, ellipsoids, npnt)
%
% See also beta_not_ellipsoids, create_not_ellipsoids.

% todo
%   % add opacity for 3D case (i.e. as wireframe)

nellipsoids = size(ellipsoids, 1);

held = takehold(ax, 'local');
for i=1:nellipsoids
    qc = ellipsoids(i, 1).qc;
    rot = ellipsoids(i, 1).rot;
    A = ellipsoids(i, 1).A;
    plot_ellipsoid(ax, qc, rot, A, npnt)
end
restorehold(ax, held)