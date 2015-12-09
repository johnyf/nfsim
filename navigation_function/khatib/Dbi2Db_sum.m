function [DU] = Dbi2Db_sum(bi, Dbi, h, b0)
% Dbi2Db    gradient Db of sum b of obstacle functions bi
%
% input
%   Dbi = obstacle function gradients at calculation points
%       = {#obstacles x 1}
%       = {[#dimensions x #points]; ;;; } (if #obstacles > 1)
%       OR
%       = [#dimensions x #points] (if #obstacles == 1)
%
% output
%   Db = [#dimensions x #points]
%
% See also bi2b, D2bi2D2b, biDbiD2bi2bDbD2b.
%
% File:      Dbi2Db_sum.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.12.02
% Language:  MATLAB R2011b
% Purpose:   calculate Db from individual obstacles' Dbi, bi and b
% Copyright: Ioannis Filippidis, 2011-

% derivatives Dbi of individual obstacle implicit functions provided
if ~iscell(Dbi)
    DU = Dbi;
    return
end

curDbi = Dbi{1, 1}(:, 1);

ndim = size(curDbi, 1);
npnt = size(bi, 2);
nobst = size(Dbi, 1);

DU = nan(ndim, npnt);

for j=1:npnt
    DUi_coef = -h .*(1 /bi(1, j) -1 /b0) ./bi(1, j).^2;
    curDU = Dbi{1, 1}(:, j) .*DUi_coef;
    
    for i=2:nobst
        DUi_coef = -h .*(1 ./bi(i, j) -1 ./b0) ./bi(i, j).^2;
        curDU = curDU +Dbi{i, 1}(:, j) .*DUi_coef;
    end

    DU(:, j) = curDU;
end
