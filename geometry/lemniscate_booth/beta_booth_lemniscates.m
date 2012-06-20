function [bi, Dbi, D2bi] = beta_booth_lemniscates(q, lemniscates)
%
% File:      beta_booth_lemniscates.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.05.25
% Language:  MATLAB R2012a
% Purpose:   multiple implicit Booth lemniscate obstacle
% Copyright: Ioannis Filippidis, 2011-

npnt = size(q, 2);
no = size(lemniscates, 1);

bi = nan(no, npnt);
D2bi = cell(no, npnt);

%% single quadric
if no == 1    
    curlemniscate = lemniscates(1, 1);
    
    qc = curlemniscate.qc;
    a = curlemniscate.a;
    b = curlemniscate.b;
    e = curlemniscate.e;
    
    [b1, Db1, D2b1] = beta_lemniscate_booth2(q, qc, a, b, e);
    bi(1, :) = b1;
    Dbi = Db1;
    D2bi = D2b1;
    
    return
end

%% multiple quadrics
Dbi = cell(no, 1);

for i=1:no
    curlemniscate = lemniscates(i, 1);
    
    qc = curlemniscate.qc;
    a = curlemniscate.a;
    b = curlemniscate.b;
    e = curlemniscate.e;
    
    [b1, Db1, D2b1] = beta_lemniscate_booth2(q, qc, a, b, e);
    bi(i, :) = b1;
    Dbi{i, 1} = Db1;
    D2bi(i, :) = D2b1;
end
