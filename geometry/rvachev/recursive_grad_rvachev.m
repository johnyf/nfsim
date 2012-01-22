function [R, DR] = recursive_grad_rvachev(operation, x, Dx, type, a)
% RVACHEV   Gradient of Boolean operation on two predicates.
%   RVACHEV(OPERATION, X, DX, TYPE, A) is the gradient of OPERATION
%   Boolean Rvachev function specified by TYPE, acting on array X of
%   continuous predicate function values and matrix DX of their gradients.
%
% input
%   OPERATION = string defining Boolean operation
%             = 'equivalence' |
%               'not', 'complement' |
%               'or', 'union', 'disjunction' |
%               'and', 'intersection', 'conjunction'
%   X = predicate values
%     = [1 x #predicates]
%   DX = predicate derivatives (in gradient form)
%      = [#dim x #predicates]
%   TYPE = 'a' | 'm' | 'p'
%   A = a \in (-1,1] |
%       [a, m] (a\in(-1,1] and m = even positive integer) | 
%       p = even positive integer
%
% output
%   DR = Gradient of selected Rvachev operation recursively
%        applied on elements of X.
%
% See also GRAD_RVACHEV, RVACHEV.
%
% File:      recursive_grad_rvachev.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.09.11
% Language:  MATLAB R2011a
% Purpose:   Recursive gradient of Rvachev function
% Copyright: Ioannis Filippidis, 2011-

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
    
    [R, DR] = grad_rvachev(operation, R1, DR1, R2, DR2, type, a);
    
    x(1, i) = R;
    Dx(:, i) = DR;
end

R = x(1, end);
DR = Dx(:, end);
