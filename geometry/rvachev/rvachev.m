function [R] = rvachev(operation, R1, R2, type, a)
% RVACHEV   Boolean operation on two Rvachev functions
%   RVACHEV(OPERATION, R1, R2, TYPE, A) is the boolean operation on the
%   values of the Rvachev functions R1 and R2.
%
%   OPERATION is a string defining the boolean operation.
%
%   R1, R2 are real matrices of values of Rvachev functions (R-functions).
%   This enables composition of R-functions by traversing the boolean
%   operation graph in a vectorized mode.
%
%   TYPE defines the formula of R-disjunction and R-conjunction. TYPE may
%   be empty for a complement operation.
%
%   A is the parameter defining the R-operation.
%
% input
%   OPERATION = 'equivalence' |
%               'not', 'complement' |
%               'or', 'union', 'disjunction' |
%               'and', 'intersection', 'conjunction' |
%   R1, R2 = matrices of values of R-functions (equal in size)
%   TYPE = 'a'| 'm' | 'p'
%   A = a \in (-1,1] |
%       [a, m] (a\in(-1,1] and m = even positive integer) | 
%       p = even positive integer
%
% output
%   R = Specified Rvachev operation acted on R1 and R2.
%
% Examples:
%   R1 = [1, 2];
%   R2 = [3, 4];
% 
%   Ru = rvachev('union', R1, R2, 'a', 0);
%   Ru = rvachev('union', R1, R2, 'm', [1, 2]);
%   Ri = rvachev('intersection', R1, R2, 'p', 4);
%   Rc = rvachev('complement', R1, R2, [], []);
%
% Note: a is implemented here as a constant and not as an arbitrary 
%       symmetric function
%
% See also GRAD_RVACHEV, RECURSIVE_RVACHEV.
%
% File:      rvachev.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2010.11.11 - 2011.09.11
% Language:  MATLAB R2011b
% Purpose:   Binary Rvachev function operations
% Copyright: Ioannis Filippidis, 2010-

%% check args
if ~isequal(size(R1), size(R2) )
    error(['Predicate row vectors R1, R2 should be ',...
           'of equal size.'] )
end

%% calculate
[R, k] = assign_rvachev_operation(operation, R1, R2, a);

if ~isempty(R)
    return
end

switch type
    case 'a'
        if (a <= -1) || (a > 1)
            error('Parameter a value is not within the interval (-1,1].')
        end
        R = (R1 +R2 +k .*sqrt(R1.^2 +R2.^2 -2.*a.*R1.*R2)) ./(1 +a);
    case 'm'
        m = a(1,2);
        a = a(1,1);
        
        if (a <= -1) || (a > 1)
            error('Parameter a value is not within the interval (-1,1].')
        end
        
        if (rem(m,2) ~= 0) || (m <= 0)
            error('Parameter m value is not an even positive integer.')
        end
        R = (R1 +R2 +k .*sqrt(R1.^2 +R2.^2 -2.*a.*R1.*R2))...
            .*(R1.^2 +R2.^2 -2.*a.*R1.*R2).^(m/2);
    case 'p'
        p = a;
        if (rem(p ,2) ~= 0) || (p <= 0)
            error('Parameter p value is not an even positive integer.')
        end
        R = R1 +R2 +k .*(R1.^p +R2.^p).^(1/p);
    otherwise
        error( ['Unknown type of Rvachev operation. '...
            'Valid types are: ''a'', ''m'', ''p''.'] )
end
