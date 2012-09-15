function [R, DR] = recursive_grad_rvachev_row(operation, x, Dx, type, a)
%RECURSIVE_GRAD_RVACHEV_ROW   Gradient of Boolean operation on two predicates.
%   [R, DR] = RECURSIVE_GRAD_RVACHEV_ROW(operation, x, Dx, type, a) is the
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
%     = [1 x #pnts]
%   Dx = predicate derivatives (in gradient form)
%      = [#dim x #pnts]
%   type = 'a' | 'm' | 'p'
%   a \in (-1,1] |
%       [a, m] (a\in(-1,1] and m = even positive integer) | 
%       p = even positive integer
%
% output
%   R = selected Rvachev operation recursively applied on elements of x.
%     = scalar
%   DR = Gradient of selected Rvachev operation recursively
%        applied on elements of x.
%      = [#dim x 1]
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
[n, m] = size(x);

if n ~= 1
    error('Operating only on row vectors.')
end

if iscell(Dx)
    error('Matrix with gradients as columns Dx cannot be a cell array.')
end

if size(Dx, 2) ~= m
    error(['Gradient matrix Dx size does not correspond',...
           'to number of predicates x.'] )
end

%% calculations
for i=2:m
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
