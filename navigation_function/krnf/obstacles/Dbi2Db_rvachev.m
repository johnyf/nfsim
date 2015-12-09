function [Db] = Dbi2Db_rvachev(bi, Dbi, operation, type, a)
%DBI2DB_RVACHEV    Gradient Db of Rvachev function of obstacles bi.
%
% usage
%   Db = DBI2DB_RVACHEV(Dbi, bi, operation, type, a)
%
% input
%   Dbi = obstacle function gradients at calculation points
%       = {#obstacles x 1}
%       = {[#dimensions x #points]; ;;; } (if #obstacles > 1)
%       OR
%       = [#dimensions x #points] (if #obstacles == 1)
%   bi  = values of obstacle functions at calculation points
%       = [#obstacles x #points]
%   operation = 'equivalence' |
%               'not', 'complement' |
%               'or', 'union', 'disjunction' |
%               'and', 'intersection', 'conjunction'
%   type = 'a'| 'm' | 'p'
%   a = parameter(s) of selected Rvachev operation
%     \in (-1,1] |
%     [a, m] (a\in(-1,1] and m = even positive integer) | 
%       p = even positive integer
%
% output
%   Db = Rvachev function gradient
%      = [#dimensions x #points]
%
% See also BI2B_RVACHEV, D2BI2D2B_RVACHEV, BIDBID2BI2BDBD2B_RVACHEV.
%
% File:      Dbi2Db_rvachev.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.01.27
% Language:  MATLAB R2011b
% Purpose:   calculate Db from individual obstacles' Dbi, bi
% Copyright: Ioannis Filippidis, 2011-

% dependency
%   recursive_grad_rvachev

% todo
%   replace with tree evaluation (depth N = log2(M) )

% derivatives Dbi of individual obstacle implicit functions provided ?
if ~iscell(Dbi)
    Db = Dbi;
    return
end

%curDbi = Dbi{1, 1}(:, 1);

%ndim = size(curDbi, 1);
%npnt = size(bi, 2);
%nobst = size(Dbi, 1);

%Db = nan(ndim, npnt);

[~, Db] = recursive_grad_rvachev(operation, bi, Dbi, type, a);

%{
for j=1:npnt
    curbi = bi(:, j);
    
    curDbi = nan(ndim, nobst);
    for i=1:nobst
        curDbi(:, i) = Dbi{i, 1}(:, j);
    end

    [~, curDb] = recursive_grad_rvachev(operation, curbi.', curDbi, type, a);
    
    Db(:, j) = curDb;
end
%}
