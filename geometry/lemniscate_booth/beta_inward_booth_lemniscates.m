function [bi, Dbi, D2bi] = beta_inward_booth_lemniscates(q, lemniscates)
%
% File:      beta_inward_booth_lemniscates.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.05.25
% Language:  MATLAB R2012a
% Purpose:   
% Copyright: Ioannis Filippidis, 2011-

[bi, Dbi, D2bi] = beta_booth_lemniscates(q, lemniscates);
bi = -bi;

if iscell(Dbi)
    Dbi = cellfun(@uminus, Dbi);
else
    Dbi = -Dbi;
end

if iscell(D2bi)
    D2bi = cellfun(@uminus, D2bi);
else
    D2bi = -D2bi;
end
