function [b] = bi2b_rvachev(bi, operation, type, a)
%BI2B_RVACHEV   Recursive rvachev conjunction of obstacles.
%
% usage
%   b = BI2B_RVACHEV(bi, operation, type, a)
%
% input
%   bi = values of obstacle functions at calculation points
%      = [#obstacles x #points]
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
%   b = values of Rvachev function of obstacle functions
%     = [1 x #points]
%
% See also DBI2DB_RVACHEV, D2BI2D2B_RVACHEV, BIDBID2BI2BDBD2B_RVACHEV.
%
% File:      bi2b_rvachev.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.01.27
% Language:  MATLAB R2011b
% Purpose:   calculate b from individual obstacles' bi
% Copyright: Ioannis Filippidis, 2011-

% dependency
%   recursive_rvachev

b = recursive_rvachev(operation, bi.', type, a).';
%{
npnt = size(bi, 2);
b = nan(1, npnt);
for i=1:npnt
    curbi = bi(:, i);
    
    b(1, i) = recursive_rvachev(operation, curbi.', type, a);
end
%}
