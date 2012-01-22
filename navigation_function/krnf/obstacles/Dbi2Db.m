function [Db] = Dbi2Db(Dbi, b, bi)
% Dbi2Db    gradient Db of product b of obstacle functions bi
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
% See also bi2b, D2bi2D2b, biDbiD2bi2bDbD2b.
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
    curDb = Dbi{1, 1}(:, j) .*b(1, j) ./bi(1, j);

    for i=2:nobst
        curDb = curDb +Dbi{i, 1}(:, j) .*b(1, j) ./bi(i, j);
    end

    Db(:, j) = curDb;
end
