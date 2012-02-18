function [R] = recursive_rvachev(operation, x, type, a)
%
% usage
%   [R] = RECURSIVE_RVACHEV(operation, x, type, a)
%
% input
%   operation = string defining Boolean operation
%             = 'equivalence' |
%               'not', 'complement' |
%               'or', 'union', 'disjunction' |
%               'and', 'intersection', 'conjunction'
%   x = predicate values
%     = [1 x #predicates]
%   type = 'a' | 'm' | 'p'
%   A = a \in (-1,1] |
%       [a, m] (a\in(-1,1] and m = even positive integer) | 
%       p = even positive integer
%
% output
%   R = Selected Rvachev function of predicates X
%     = [1 x 1]
%
% Remark: practically for large numbers only 'p' works
%
% See also RECURSIVE_GRAD_RVACHEV, RVACHEV.
%
% File:      recursive_rvachev.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.09.10
% Language:  MATLAB R2011b
% Purpose:   Recursive Rvachev function
% Copyright: Ioannis Filippidis, 2011-

if size(x, 1) ~= 1
    error('Operating only on row vectors.')
end

n = size(x, 2);

for i=2:n
    R1 = x(1, i-1);
    R2 = x(1, i);
    
    R = rvachev(operation, R1, R2, type, a);
    
    x(1, i) = R;
end

R = x(1, end);
