function [R, DR, D2R] = recursive_hessian_rvachev_row(operation, x, Dx, D2x, type, a)
%RECURSIVE_HESSIAN_RVACHEV_ROW   Gradient of Boolean operation on two predicates.
%   [R, DR, D2R] = RECURSIVE_HESSIAN_RVACHEV_ROW(operation, x, Dx, D2x, type, a) is the
%   gradient of operation Boolean Rvachev function specified by type,
%   acting on array x of continuous predicate function values and matrix
%   Dx of their gradients.
%
% usage
%   [R, DR, D2R] = RECURSIVE_HESSIAN_RVACHEV_ROW(operation, x, Dx, D2x, type, a)
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
    
    D2R1 = D2x{1, i-1};
    D2R2 = D2x{1, i};
    
    R = rvachev(operation, R1, R2, type, a);
    DR = grad_rvachev(operation, R1, DR1, R2, DR2, type, a);
    D2R = hessian_rvachev(operation, R1, DR1, D2R1,...
                                     R2, DR2, D2R2, type, a);
    
    x(1, i) = R;
    Dx(:, i) = DR;
    D2x{1, i} = D2R;
end

R = x(1, end);
DR = Dx(:, end);
D2R = D2x{1, end};
