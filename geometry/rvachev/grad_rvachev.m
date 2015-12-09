function [DR] = grad_rvachev(operation, R1, DR1, R2, DR2, type, a)
%GRAD_RVACHEV   Gradient of Rvachev function.
%   DR = GRAD_RVACHEV(operation, R1, DR1, R2, DR2, type, a) returns
%   the gradient of the Rvachev function selected by: operation.
%
%   Let q = [#dim x 1] be a vector of variables.
%   It is assumed that R1(q), R2(q) are both real functions of multiple
%   variables q(i), the components of vector q.
%   DR1, DR2 are the gradient of functions R1(q), R2(q), with respect to q.
%   In more detail:
%       DR1 = \nabla_q R_1(q)
%       DR2 = \nabla_q R_2(q)
%   For the operation, type, a arguments please refer to function rvachev.
%
% usage
%   DR = GRAD_RVACHEV(operation, R1, DR1, R2, DR2, type, a)
%
% input
%   OPERATION = 'or', 'union', 'disjunction' |
%               'and', 'intersection', 'conjunction' |
%   R1, R2 = arrays of values of R-functions (equal in size)
%          = [1 x m]
%   DR1, DR2 = gradients of continuous predicate functions R1, R2
%            = [#dimensions x m]
%   TYPE = 'a'| 'm' | 'p'
%   A = a \in (-1,1] |
%       [a, m] (a\in(-1,1] and m = even positive integer) | 
%       p = even positive integer
%
% output
%   DR = Gradient of selected Rvachev operation applied to R1 and R2.
%
% See also RVACHEV, HESSIAN_RVACHEV, RECURSIVE_GRAD_RVACHEV.
%
% File:      grad_rvachev.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.09.11
% Language:  MATLAB R2011a
% Purpose:   Gradient of Rvachev function
% Copyright: Ioannis Filippidis, 2011-

% dependency
%   assign_rvachev_operation

%% check args
[n1, m1] = size(R1);
[n2, m2] = size(R2);

if (n1 ~= 1) || (n2 ~= 1)
    error('Predicates R1, R2 should be row vectors.')
end

if m1 ~= m2
    error('Row vectors R1, R2 should have same number of columns.')
end

[dim1, md1] = size(DR1);
[dim2, md2] = size(DR2);

if dim1 ~= dim2
    error('dim(DR1) ~= dim(DR2) for predicate gradients.')
end

if md1 ~= md2
    error('Matrices DR1, DR2 should have same number of gradients as columns.')
end

if m1 ~= md2
    error(['Row vector R1 should have same number of columns with ',...
           'the gradients (as columns) of matrix DR1.'] )
end

if ~ismember(operation, {'or', 'union', 'disjunction', '||', '|',...
        'and', 'intersection', 'conjunction', '&&', '&'} )
    error('Only AND, OR operations yet supported for Rvachev gradients.')
end

%% calculate
[~, k] = assign_rvachev_operation(operation, R1, R2, a);

% Note: arg error checking implemented in RVACHEV called above
switch type
    case 'p'
        p = a;
        
        c1 = 1 +k .*(R1.^p +R2.^p).^(1/p -1) .*R1.^(p-1);
        c2 = 1 +k .*(R1.^p +R2.^p).^(1/p -1) .*R2.^(p-1);
        
        t1 = bsxfun(@times, c1, DR1);
        t2 = bsxfun(@times, c2, DR2);
        
        DR = t1 +t2;
    otherwise
        error('Unsupported Rvachev TYPE for gradients.')
end
