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
%     = [n x #pnts]
%   Dx = predicate gradients
%      = {n x 1}
%      = {[#dim x #pnts]; ... }
%   type = 'a' | 'm' | 'p'
%   a \in (-1,1] |
%       [a, m] (a\in(-1,1] and m = even positive integer) | 
%       p = even positive integer
%
% output
%   R = selected Rvachev operation recursively applied on elements of x
%     = [1 x #pnts]
%   DR = Gradient of selected Rvachev operation recursively applied
%      = [#dim x #pnts]
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
[nd, md] = size(Dx);

if n ~= nd
    error('Matrix x should have same number of rows with (column) cell array Dx.')
end

if md ~= 1
    error('Cell array of matrices with gradients as columns Dx should have 1 column.')
end

[ndim, md] = size(Dx{1, 1} );

if md ~= m
    error('Matrix x should have same number of columns with gradients (as columns) in matrix Dx.')
end

%% calculations
for i=2:n
    R1 = x(i-1, :);
    R2 = x(i, :);
    
    DR1 = Dx{i-1, 1};
    DR2 = Dx{i, 1};
    
    R = rvachev(operation, R1, R2, type, a);
    DR = grad_rvachev(operation, R1, DR1, R2, DR2, type, a);
    
    x(i, :) = R;
    Dx{i, 1} = DR;
end

R = x(end, :);
DR = Dx{end, 1};
