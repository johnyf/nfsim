function [R, DR, D2R] = recursive_hessian_rvachev(operation, x, Dx, D2x, type, a)
%RECURSIVE_HESSIAN_RVACHEV   Gradient of Boolean operation on two predicates.
%   [R, DR, D2R] = RECURSIVE_HESSIAN_RVACHEV(operation, x, Dx, D2x, type, a) is the
%   gradient of operation Boolean Rvachev function specified by type,
%   acting on array x of continuous predicate function values and matrix
%   Dx of their gradients.
%
% usage
%   [R, DR, D2R] = RECURSIVE_HESSIAN_RVACHEV(operation, x, Dx, D2x, type, a)
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
%      = {[#dim x #pnts], ... }
%   D2x = predicate Hessian matrices
%       = {n x #pnts}
%       = {[#dim x #dim], ... }
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
% See also RECURSIVE_RVACHEV, RECURSIVE_GRAD_RVACHEV, HESSIAN_RVACHEV.
%
% File:      recursive_hessian_rvachev.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.05.17
% Language:  MATLAB R2012a
% Purpose:   Recursive Hessian matrix of Rvachev function
% Copyright: Ioannis Filippidis, 2012-

% dependency
%   hessian_rvachev

%% check args
[n, m] = size(x);
[nd, md] = size(Dx);

if n ~= nd
    error('Matrix x should have same number of rows with (column) cell array Dx.')
end

if md ~= 1
    error('Cell array of matrices with gradients as columns Dx should have 1 column.')
end

md = size(Dx{1, 1}, 2);

if md ~= m
    error('Matrix x should have same number of columns with gradients (as columns) in matrix Dx.')
end

[nd2, md2] = size(D2x);

if n ~= nd2
    error('Matrix x and cell array of Hessian matrices D2x should have same number of rows.')
end

if m ~= md2
    error('Matrix x and cell array of Hessian matrices D2x should have same number of columns.')
end

%% calculations
for i=2:n
    R1 = x(i-1, :);
    R2 = x(i, :);
    
    DR1 = Dx{i-1, 1};
    DR2 = Dx{i, 1};
    
    D2R1 = D2x(i-1, :);
    D2R2 = D2x(i, :);
    
    R = rvachev(operation, R1, R2, type, a);
    DR = grad_rvachev(operation, R1, DR1, R2, DR2, type, a);
    D2R = hessian_rvachev(operation, R1, DR1, D2R1,...
                                     R2, DR2, D2R2, type, a);
    
    x(i, :) = R;
    Dx{i, 1} = DR;
    D2x(i, :) = D2R;
end

R = x(end, :);
DR = Dx(end, 1);
D2R = D2x(end, :);
