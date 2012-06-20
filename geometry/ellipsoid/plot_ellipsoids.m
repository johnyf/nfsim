function [q, X, Y, Z] = plot_ellipsoids(ax, ellipsoids, npnt)
nellipsoids = size(ellipsoids, 1);

held = takehold(ax, 'local');
for i=1:nellipsoids
    qc = ellipsoids(i, 1).qc;
    rot = ellipsoids(i, 1).rot;
    A = ellipsoids(i, 1).A;
    [q, X, Y, Z] = plot_ellipsoid(ax, qc, rot, A, npnt);
end
restorehold(ax, held)

if nargout == 0
    clear('q')
end
