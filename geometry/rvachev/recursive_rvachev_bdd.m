function [R] = recursive_rvachev_bdd(operation, x, type, a)
%RECURSIVE_RVACHEV_BDD  Tree Rvachev operation along rows.
%
% usage
%   R = RECURSIVE_RVACHEV_BDD(operation, x, type, a)
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
% See also RECURSIVE_GRAD_RVACHEV, RECURSIVE_HESSIAN_RVACHEV, RVACHEV,
%          RVACHEV_PREDICATE_BDD.
%
% File:      recursive_rvachev_bdd.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.09.07
% Language:  MATLAB R2012a
% Purpose:   Recursive Rvachev function using a Binary Decision Diagram
%            Comment: yields MUCH better (scalable) results than its linear
%            counterpart recursive_rvachev, although its time computational
%            complexity is again linear (and almost the same)
% Copyright: Ioannis Filippidis, 2012-

% dependency
%   rvachev

% todo
%   prime factors

x = x.';

% per level of depth
while size(x, 2) ~= 1
    x = operate_per_level(operation, x, type, a);
end

R = x.';

function [R] = operate_per_level(operation, x, type, a)

m = size(x, 2);
if mod(m, 2) ~= 0
    xlast = x(:, m);
    I = 1:(m -1);
    x = x(:, I);
else
    xlast = [];
end

% depth of operations
m = size(x, 2);
n = log2(m);

for i=1:2:n
    R1 = x(:, i);
    R2 = x(:, i+1);
    
    R12 = rvachev(operation, R1, R2, type, a);
    
    x(:, i) = R12;
end

x = x(:, 1:2:end);

if isempty(xlast)
    R = x;
    return
end

m = size(x, 2);
R1 = x(:, m);
R2 = xlast;

R12 = rvachev(operation, R1, R2, type, a);
I = 1:(m-1);
R = [x(:, I), R12];
