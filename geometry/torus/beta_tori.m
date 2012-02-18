function [bi, Dbi, D2bi] = beta_tori(q, tori)
%BETA_TORI  multiple tori implicit functions and gradients.
%
% See also BETA_TORUS, BETA_HETEROGENOUS, BIDBID2BI2BDBD2B.
%
% File:      beta_tori.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.09.11
% Language:  MATLAB R2011a
% Purpose:   multiple implicit tori
% Copyright: Ioannis Filippidis, 2011-

npnt = size(q, 2);
no = size(tori, 1);

bi = nan(no, npnt);
Dbi = cell(no, 1);
D2bi = cell(no, npnt);
for i=1:no
    curtorus = tori(i, 1);
    
    qc = curtorus.qc;
    r = curtorus.r;
    R = curtorus.R;
    rot = curtorus.rot;

    [b1, Db1, D2b1] = beta_torus(q, qc, r, R, rot);
    bi(i, :) = b1;
    Dbi{i, 1} = Db1;
    D2bi(i, :) = D2b1;
end
