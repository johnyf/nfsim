function [D2b] = D2bi2D2b(b, bi, Db, Dbi, D2bi)
%D2BI2D2B   Hessian matrix for product of obstacle functions.
%
%usage
%-----
%   [D2b] = D2BI2D2B(D2bi, Db, Dbi, b, bi)
%
%input
%-----
%   b = product obstacle function at calculation points
%     = [1 x #points]
%     = bi2b(bi)
%   bi = obstacle functions at calculation points
%      = [#obstacles x #points]
%   Db = product obstacle function gradient at calculation points
%      = [#dimensions x #points]
%   Dbi = obstacle function gradients at calculation points
%       = {#obstacles x 1}
%       = {[#dimensions x #points]; ;;; } (if #obstacles > 1)
%       OR
%       = [#dimensions x #points] (if #obstacles == 1)
%   D2bi = individual obstacles' Hessian matrices
%          at calculation points
%        = {#obstacles x #points}
%
%output
%------
%   D2b = obstacle product function Hessian matrices at calculation points
%       = {1 x #points}
%       = {[#dimensions x #dimensions], ...}
%
%about
%-----
% 2011.11.26 (c) Ioannis Filippidis, jfilippidis@gmail.com
%
% See also DBI2DB, BI2B, BIDBID2BI2BDBD2B.

% single obstacle only?
if ~iscell(Dbi)
    D2b = D2bi;
    return
end

% check single obstacle with cell
if size(Dbi, 1) == 1
    warning('Dbi:cell', 'Single obstacle for which Dbi is a cell array.')
    %D2b = D2bi;
    %return
end

curDbi = Dbi{1, 1}(:, 1);

ndim = size(curDbi, 1);
npnt = size(bi, 2);
nobst = size(Dbi, 1);

D2b = cell(1, npnt);

% at each calculation point
for j=1:npnt
    s = zeros(ndim);
    
    % for each obstacle
    for i=1:nobst
        curbi = bi(i, j);
        curDbi = Dbi{i, 1}(:, j);
        curD2bi = D2bi{i, j};
        
        s = s +curDbi *curDbi.' ./(curbi^2) ...
              -curD2bi ./curbi;
    end
    
    curb = b(1, j);
    curDb = Db(:, j);
    curD2b = curDb *curDb.' ./curb -curb *s;
    
    D2b{1, j} = curD2b;
end
