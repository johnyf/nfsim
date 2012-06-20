function [D2R] = hessian_rvachev(operation, R1, DR1, D2R1,...
                                            R2, DR2, D2R2, type, a)
%HESSIAN_RVACHEV   Hessian matrix of Rvachev function.
%   D2R = HESSIAN_RVACHEV(operation, R1, DR1, D2R1, R2, DR2, D2R2, type, a)
%   returns the Hessian matrix of the Rvachev function selected by:
%   operation.
%
% usage
%   D2R = HESSIAN_RVACHEV(operation, R1, DR1, D2R1, R2, DR2, D2R2, type, a)
%
% input
%   operation = 'or', 'union', 'disjunction' |
%               'and', 'intersection', 'conjunction' |
%   R1, R2 = arrays of values of R-functions (equal in size)
%          = [1 x #predicates]
%   DR1, DR2 = gradients of continuous predicate functions R1, R2
%            = [#dimensions x #predicates]   
%   type = 'a'| 'm' | 'p'
%   a = a \in (-1,1] |
%       [a, m] (a\in(-1,1] and m = even positive integer) | 
%       p = even positive integer
%
% output
%   D2R = Hessian matrix of selected Rvachev operation applied to R1 and R2
%
% See also RVACHEV, GRAD_RVACHEV, RECURSIVE_HESSIAN_RVACHEV.
%
% File:      hessian_rvachev.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.05.17
% Language:  MATLAB R2012a
% Purpose:   Hessian of Rvachev function
% Copyright: Ioannis Filippidis, 2012-

% dependency
%   assign_rvachev_operation

%todo!!!: incorporate k

%% check args
n1 = size(R1, 1);
n2 = size(R2, 1);

if (n1 ~= 1) || (n2 ~= 1)
    error(['Predicate matrices R1, R2 should be ',...
           'row vectors [1 x #predicates] '] )
end

if ~isequal(size(DR1), size(DR2) )
    error(['Predicate gradient vectors DR1, DR2 should be ',...
           'of same dimension (# of rows).'] )
end

m = size(R1, 2);
mD = size(DR1, 2);

if m ~= mD
    error(['Predicates and their gradients are of ',...
           'different numbers.'] )
end

if ~ismember(operation, {'or', 'union', 'disjunction', '||',...
        'and', 'intersection', 'conjunction', '&&'} )
    error('Only AND, OR operations yet supported for Rvachev gradients.')
end

%% calculate
[~, k] = assign_rvachev_operation(operation, R1, R2, a);

% Note: arg error checking implemented in RVACHEV called above
switch type
    case 'p'
        D2R = p_hessian(R1, DR1, D2R1, R2, DR2, D2R2, a, k);
    otherwise
        error('Unsupported Rvachev TYPE for gradients.')
end

function [D2R] = p_hessian(R1, DR1, D2R1, R2, DR2, D2R2, p, k)
% coefficients
c(1, :) = (1 +R1.^(p -1) .*(R1.^p +R2.^p).^(1 /p -1) );
        
c(2, :) = (1 +R2.^(p -1) .*(R1.^p +R2.^p).^(1 /p -1) );

c(3, :) = (1 -p) .*R1.^(2*p -2) .*(R1.^p +R2.^p).^(1 /p -2)...
         +(p -1) .*R1.^(p -2)   .*(R1.^p +R2.^p).^(1 /p -1);

c(4, :) = (1 -p) .*R2.^(2*p -2) .*(R1.^p +R2.^p).^(1 /p -2)...
         +(p -1) .*R2.^(p -2)   .*(R1.^p +R2.^p).^(1 /p -1);

c(5, :) = (1 -p) .*(R1.^p +R2.^p).^(1 /p -2) .*R1.^(p -1) .*R2.^(p -1);

% compute at each point
n = size(R1, 2);
D2R = cell(1, n);
for i=1:n
    curDR1 = DR1(:, i);
    curDR2 = DR2(:, i);
    
    curD2R1 = D2R1{1, i};
    curD2R2 = D2R2{1, i};
    
    curc = c(:, i);
    
    curD2R = single_hessian(curDR1, curD2R1, curDR2, curD2R2, curc);
    
    D2R{1, i} = curD2R;
end

function [D2R] = single_hessian(DR1, D2R1, DR2, D2R2, c)
D2R = c(1, 1) *D2R1 +c(2, 1) *D2R2...
     +c(3, 1) *(DR1 *DR1.')...
     +c(4, 1) *(DR2 *DR2.')...
     +c(5, 1) *(DR1 *DR2.' +DR2 *DR1.');
