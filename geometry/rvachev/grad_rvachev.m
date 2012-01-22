function [R, DR] = grad_rvachev(operation, R1, DR1, R2, DR2, type, a)
% input
%   OPERATION = 'or', 'union', 'disjunction' |
%               'and', 'intersection', 'conjunction' |
%   R1, R2 = arrays of values of R-functions (equal in size)
%          = [1 x #predicates]
%   DR1, DR2 = gradients of continuous predicate functions R1, R2
%            = [#dimensions x #predicates]   
%   TYPE = 'a'| 'm' | 'p'
%   A = a \in (-1,1] |
%       [a, m] (a\in(-1,1] and m = even positive integer) | 
%       p = even positive integer
%
% output
%   R = Specified Rvachev operation acted on R1 and R2.
%
% See also RECURSIVE_GRAD_RVACHEV, RVACHEV.
%
% File:      grad_rvachev.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.09.11
% Language:  MATLAB R2011a
% Purpose:   Gradient of Rvachev function
% Copyright: Ioannis Filippidis, 2011-

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
R = rvachev(operation, R1, R2, type, a);
[~, k] = assign_rvachev_operation(operation, R1, R2, a);

% Note: arg error checking implemented in RVACHEV called above
switch type
    case 'p'
        p = a;
        DR = DR1 +DR2...
            +k .*1 ./p .*(R1.^p +R2.^p).^(1./p -1)...
             .*(p .*R1.^(p-1) .*DR1...
               +p .*R2.^(p-1) .*DR2);
    otherwise
        error('Unsupported Rvachev TYPE for gradients.')
end
