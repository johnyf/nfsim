function [] = plot_quadrics_inward(ax, ellipsoids, npnt)
% add opacity for 3D case (i.e. as wireframe)

nellipsoids = size(ellipsoids, 1);

for i=1:nellipsoids
    qc = ellipsoids(i, 1).qc;
    rot = ellipsoids(i, 1).rot;
    A = ellipsoids(i, 1).A;
    plot_ellipsoid(ax, qc, rot, A, npnt)
end