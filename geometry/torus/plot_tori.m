function [] = plot_tori(ax, tori, npnt)
nellipsoids = size(tori, 1);

for i=1:nellipsoids
    torus = tori(i, 1);
    
    qc = torus.qc;
    r = torus.r;
    R = torus.R;
    rot = torus.rot;
    plot_torus(ax, qc, r, R, rot, npnt)
end
