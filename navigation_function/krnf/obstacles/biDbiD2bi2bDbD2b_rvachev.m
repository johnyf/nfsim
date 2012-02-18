function [b, Db, D2b] = biDbiD2bi2bDbD2b_rvachev(bi, Dbi, D2bi)
%BIDBID2BI2BDBD2B_RVACHEV   Rvachev function and derivatives for obstacles
%
% See also BETA_HETEROGENOUS, BI2B_RVACHEV, DBI2DB_RVACHEV.
%
% File:      biDbiD2bi2bDbD2b_rvachev.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.01.15 - 2012.01.27
% Language:  MATLAB R2011b
% Purpose:   calculate obstacle rvachev conjunction and its derivatives from
%            individual obstacle functions and their derivatives
% Copyright: Ioannis Filippidis, 2012-

operation = 'and';
type = 'p';
a = 2;

b = bi2b_rvachev(bi, operation, type, a);

if nargout == 2
    Db = Dbi2Db_rvachev(Dbi, bi, operation, type, a);
end

if nargout == 3
    D2b = D2bi2D2b_rvachev(D2bi, Dbi, b, bi, operation, type, a);
end
