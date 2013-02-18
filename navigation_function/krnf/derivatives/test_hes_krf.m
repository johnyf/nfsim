% test script for Koditschek-Rimon function Hessian
% (in sphere world for starters)

cls

%% initialize some ellipsoids
nellipsoids = 2;

qc = cell(nellipsoids, 1);
rot = cell(nellipsoids, 1);
A = cell(nellipsoids, 1);

% ellipsoid 1
qc{1, 1} = [2, -3, 1].';
rot{1, 1} = eye(3);

axis1 = 1;
axis2 = 1.3;
axis3 = 2.5;
A{1, 1} = radii2ellipsoid([axis1, axis2, axis3] );
%plot_ellipsoid(ax, qc{1, 1}, rot{1, 1}, A{1, 1}, npnt)

% ellipsoid 2
qc{2, 1} = [3, 2, 1].';
rot{2, 1} = eye(3);

axis1 = 1;
axis2 = 1.3;
axis3 = 1.4;
A{2, 1} = radii2ellipsoid([axis1, axis2, axis3] );
%plot_ellipsoid(ax, qc{2, 1}, rot{2, 1}, A{2, 1}, npnt)

% pack ellipsoids
quadrics = struct('qc', qc, 'rot', rot, 'A', A);

%% test analytic KRNF hessian matrix calculation
q = rand(3, 1000);
qd = [0, -1, 0].';
k = 2;

[bi, Dbi, D2bi] = beta_quadrics(q, quadrics);
[b, Db, D2b] = biDbiD2bi2bDbD2b(bi, Dbi, D2bi);
[gd, Dgd, D2gd] = gamma_d(q, qd);
%[gd, Dgd, D2gd] = dipole_gamma_d(q, qd, nx, R, m)

H = hes_krf(gd, Dgd, D2gd, b, Db, D2b, k);

h = 0.01;
npnt = size(q, 2);
numH = cell(1, npnt);
for i=1:npnt
    curq = q(:, i);
    
    pt = numhespt(curq, h);
    [bi, ~, ~] = beta_quadrics(pt, quadrics);
    b = bi2b(bi);
    
    gd = gamma_d(pt, qd);
    nf = krf(gd, b, k);
    
    numH{1, i} = numhes(nf, h);
end

%% calculate error
error_H = cell(1, npnt);
mean_error = 0;
for i=1:npnt
    curH = H{1, i};
    curnumH = numH{1, i};
    
    error_H{1, i} = 100 *(ones(size(curH) ) -curnumH ./curH);
    mean_error = mean_error +abs(error_H{1, i} );
end
mean_error = mean_error /npnt

%% for general gamma_d
% program to calculate and plot eigenvalues /normDgd
