function [R, DR] = recursive_grad_rvachev(operation, x, Dx, type, a)
%RECURSIVE_GRAD_RVACHEV   Gradient of Boolean operation on two predicates.
%   [R, DR] = RECURSIVE_GRAD_RVACHEV(operation, x, Dx, type, a) is the
%   gradient of operation Boolean Rvachev function specified by type,
%   acting on array x of continuous predicate function values and matrix
%   Dx of their gradients.
%
% usage
%   [R, DR] = RECURSIVE_GRAD_RVACHEV(operation, x, Dx, type, a)
%
% input
%   operation = string defining Boolean operation
%             = 'equivalence' |
%               'not', 'complement' |
%               'or', 'union', 'disjunction' |
%               'and', 'intersection', 'conjunction'
%   x = predicate values
%     = [1 x #predicates]
%   Dx = predicate derivatives (in gradient form)
%      = [#dim x #predicates]
%   type = 'a' | 'm' | 'p'
%   a \in (-1,1] |
%       [a, m] (a\in(-1,1] and m = even positive integer) | 
%       p = even positive integer
%
% output
%   R = selected Rvachev operation recursively applied on elements of x.
%   DR = Gradient of selected Rvachev operation recursively
%        applied on elements of x.
%
% See also RECURSIVE_RVACHEV, RECURSIVE_HESSIAN_RVACHEV, GRAD_RVACHEV.
%
% File:      recursive_grad_rvachev.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.09.11
% Language:  MATLAB R2011a
% Purpose:   Recursive gradient of Rvachev function
% Copyright: Ioannis Filippidis, 2011-

% dependency
%   grad_rvachev

%% check args
if size(x, 1) ~= 1
    error('Operating only on row vectors.')
end

n = size(x, 2);
if size(Dx, 2) ~= n
    error(['Gradient matrix DX size does not correspond',...
           'to number of predicates X.'] )
end

%% calculations
for i=2:n
    R1 = x(1, i-1);
    R2 = x(1, i);
    
    DR1 = Dx(:, i-1);
    DR2 = Dx(:, i);
    
    R = rvachev(operation, R1, R2, type, a);
    DR = grad_rvachev(operation, R1, DR1, R2, DR2, type, a);
    
    x(1, i) = R;
    Dx(:, i) = DR;
end

R = x(1, end);
DR = Dx(:, end);
