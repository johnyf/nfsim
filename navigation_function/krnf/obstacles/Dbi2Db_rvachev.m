function [Db] = Dbi2Db_rvachev(Dbi, bi, operation, type, a)
%DBI2DB_RVACHEV    gradient Db of Rvachev function of obstacles bi
%
% input
%   Dbi = obstacle function gradients at calculation points
%       = {#obstacles x 1}
%       = {[#dimensions x #points]; ;;; } (if #obstacles > 1)
%       OR
%       = [#dimensions x #points] (if #obstacles == 1)
%   bi  = [#obstacles x #points]
%
% output
%   Db = [#dimensions x #points]
%
% See also BI2B_RVACHEV, D2BI2D2B_RVACHEV, BIDBID2BI2BDBD2B_RVACHEV.
%
% File:      Dbi2Db_rvachev.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.01.27
% Language:  MATLAB R2011b
% Purpose:   calculate Db from individual obstacles' Dbi, bi
% Copyright: Ioannis Filippidis, 2011-

% derivatives Dbi of individual obstacle implicit functions provided ?
if ~iscell(Dbi)
    Db = Dbi;
    return
end

curDbi = Dbi{1, 1}(:, 1);

ndim = size(curDbi, 1);
npnt = size(bi, 2);
nobst = size(Dbi, 1);

Db = nan(ndim, npnt);

for j=1:npnt
    curbi = bi(:, j).';
    
    curDbi = nan(ndim, npnt);
    for i=1:nobst
        curDbi(:, i) = Dbi{i, 1}(:, j);
    end
    
    Db(:, j) = recursive_grad_rvachev(operation, curbi, curDbi, type, a);
end
