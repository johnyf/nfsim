function [Db] = Dbi2Db(Dbi, b, bi)
%DBI2DB    gradient Db of product b of obstacle functions bi
%
% usage
%   [Db] = DBI2DB(Dbi, b, bi)
%
% input
%   Dbi = obstacle function gradients at calculation points
%       = {#obstacles x 1}
%       = {[#dimensions x #points]; ;;; } (if #obstacles > 1)
%       OR
%       = [#dimensions x #points] (if #obstacles == 1)
%   bi  = [#obstacles x #points]
%   b = [1 x #points]
%     = bi2b(bi)
%
% output
%   Db = [#dimensions x #points]
%
% See also BI2B, D2BI2D2B, BIDBID2BI2BDBD2B.
%
% File:      Dbi2Db.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.07.31
% Language:  MATLAB R2011b
% Purpose:   calculate Db from individual obstacles' Dbi, bi and b
% Copyright: Ioannis Filippidis, 2011-

% derivatives Dbi of individual obstacle implicit functions provided
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
    curbi = bi(:, j);
    
    if curbi(1, 1) ~= 0
        curDb = Dbi{1, 1}(:, j) .*b(1, j) ./curbi(1, 1);
    else
        idx = 2:nobst;
        curbarbi = curbi(idx, 1);
        curDb = Dbi{1, 1}(:, j) .*prod(curbarbi);
    end

    for i=2:nobst
        if curbi(i, 1) ~= 0
            curDb = curDb +Dbi{i, 1}(:, j) .*b(1, j) ./curbi(i, 1);
        else
            idx = [1:(i-1), (i+1):nobst];
            curbarbi = curbi(idx, 1);
            curDb = curDb +Dbi{i, 1}(:, j) .*prod(curbarbi);
        end
    end

    Db(:, j) = curDb;
end
