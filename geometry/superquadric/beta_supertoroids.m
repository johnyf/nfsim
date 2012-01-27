function [bi, Dbi] = beta_supertoroids(q, supertoroids)

% BETA_SUPERTOROID, BETA_HETEROGENOUS, BIDBID2BI2BDBD2B.

npnt = size(q, 2);
no = size(supertoroids, 1);

bi = nan(no, npnt);
Dbi = cell(no, 1);
for i=1:no
    curtoroid = supertoroids(i, 1);
    
    qc = curtoroid.qc;
    a = curtoroid.a;
    e = curtoroid.e;
    r = curtoroid.r;
    rot = curtoroid.rot;

    [b1, Db1] = beta_supertoroid(q, qc, a, e, r, rot);
    bi(i, :) = b1;
    Dbi{i, 1} = Db1;
end
