function [R] = recursive_rvachev(operation, x, type, a)
%RECURSIVE_RVACHEV  Apply Rvachev operation recursively over array.
%
% usage
%   R = RECURSIVE_RVACHEV(operation, x, type, a)
%
% input
%   operation = string defining Boolean operation
%             = 'equivalence' |
%               'not', 'complement' |
%               'or', 'union', 'disjunction' |
%               'and', 'intersection', 'conjunction'
%   x = predicate values
%     = [#rows x #predicates]
%   type = 'a' | 'm' | 'p'
%   A = a \in (-1,1] |
%       [a, m] (a\in(-1,1] and m = even positive integer) | 
%       p = even positive integer
%
% output
%   R = Selected Rvachev function of predicates X
%     = [#rows x 1]
%
% Remark: For large numbers only 'p' works in practice.
%
% See also RECURSIVE_GRAD_RVACHEV, RECURSIVE_HESSIAN_RVACHEV, RVACHEV.
%
% File:      recursive_rvachev.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.09.10 - 2012.05.17
% Language:  MATLAB R2012a
% Purpose:   Recursive Rvachev function
% Copyright: Ioannis Filippidis, 2011-

% dependency
%   rvachev

[n, m] = size(x);
%{
if n ~= 1
    warning('rvachev:rows', ['Multiple rows. Operating along columns ',...
            'to return a column vector. The Rvachev operator acts ',...
            'among predicates on the same row.'] )
end
%}
for i=2:m
    R1 = x(:, i-1);
    R2 = x(:, i);
    
    R = rvachev(operation, R1, R2, type, a);
    
    x(:, i) = R;
end

R = x(:, end);
