function [R] = rvachevn(operation, x, m)
%RVACHEVN   N-ary Rvachev operation.
%
% usage
%   R = RVACHEVN(operation, x, m)
%
% input
%   operation = string
%             = 'not', 'complement' |
%             = 'or', 'union', 'disjunction', '||' |
%             = 'and', 'intersection', 'conjunction', '&&'
%   X = [1 x #predicates]
%   M = even integer
%
% output
%   R = N-ary Rvachev operation acted recursively on
%       elements of row vector X
%     = [1 x 1]
%
% See also RVACHEV.
%
% File:      rvachevn.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.09.10
% Language:  MATLAB R2011a
% Purpose:   N-ary Rvachev function
% Copyright: Ioannis Filippidis, 2011-

if size(x, 1) ~= 1
    error('Operating only on row vectors.')
end

switch operation
    case {'not', 'complement'}
        R = -x;
    case {'or', 'union', 'disjunction', '||'}
        if (rem(m,2) ~= 0) || (m <= 0)
            error('Parameter m value is not an even positive integer.')
        end
        
        S = x.^m .*(x +abs(x) );
        P = (-1).^m .*x.^m .*(abs(x) -x); 
        
        R = sum(S) -prod(P);
    case {'and', 'intersection', 'conjunction', '&&'}
        if (rem(m,2) ~= 0) || (m <= 0)
            error('Parameter m value is not an even positive integer.')
        end
        
        S = (-1).^m .*x.^m .*(x -abs(x) );
        P = x.^m .*(x +abs(x) );
        
        R = sum(S) +prod(P);
    otherwise
        error('Unknown operation on Rvachev functions.')
end
