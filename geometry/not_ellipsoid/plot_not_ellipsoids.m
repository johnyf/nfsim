function [] = plot_not_ellipsoids(ax, ellipsoids, npnt)
%
% See also beta_not_ellipsoids, create_not_ellipsoids.

nellipsoids = size(ellipsoids, 1);

held = takehold(ax, 'local');
for i=1:nellipsoids
    qc = ellipsoids(i, 1).qc;
    rot = ellipsoids(i, 1).rot;
    A = ellipsoids(i, 1).A;
    
    if size(qc, 1) > 2
        plot_ellipsoid(ax, qc, rot, A, npnt, 'FaceColor', 'None')
    else
        plot_ellipsoid(ax, qc, rot, A, npnt)
    end
end
restorehold(ax, held)
