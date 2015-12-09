function [D2b] = D2bi2D2b_rvachev(bi, Dbi, D2bi, operation, type, a)
%D2BI2D2B_RVACHEV   Rvachev operation between Hessian matrices.
%
% See also BI2B_RVACHEV, DBI2DB_RVACHEV, BIDBID2BI2BDBD2B_RVACHEV.

% dependency
%   recursive_hessian_rvachev

% todo
%   replace with tree evaluation (depth N = log2(M) )

% single obstacle only?
if ~iscell(Dbi)
    D2b = D2bi;
    return
end

%curDbi = Dbi{1, 1}(:, 1);

%ndim = size(curDbi, 1);
%npnt = size(bi, 2);
%nobst = size(Dbi, 1);

%D2b = cell(1, npnt);

[~, ~, D2b] = recursive_hessian_rvachev(operation, bi, Dbi, D2bi, type, a);
%{
% at each calculation point
for j=1:npnt
    curbi = bi(:, j);
    
    curDbi = nan(ndim, nobst);
    for i=1:nobst
        curDbi(:, i) = Dbi{i, 1}(:, j);
    end
    
    curD2bi = D2bi(:, j).';
    
    [~, ~, curD2b] = recursive_hessian_rvachev(operation, curbi.', curDbi, curD2bi, type, a);
    
    D2b{1, j} = curD2b;
end
%}
