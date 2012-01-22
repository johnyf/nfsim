function [bi, Dbi] = beta_superellipsoids(q, superellipsoids)
%
% See also BETA_SUPERQUADRIC.

npnt = size(q, 2);
no = size(superellipsoids, 1);

bi = nan(no, npnt);
Dbi = cell(no, 1);
for i=1:no
    curellipsoid = superellipsoids(i, 1);
    
    qc = curellipsoid.qc;
    a = curellipsoid.a;
    e = curellipsoid.e;
    R  =curellipsoid.R;

    [b1, Db1] = beta_superellipsoid(q, qc, a, e, R);
    bi(i, :) = b1;
    Dbi{i, 1} = Db1;
end
