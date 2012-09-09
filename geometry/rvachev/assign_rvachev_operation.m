function [R, k] = assign_rvachev_operation(operation, R1, R2, a)
%ASSIGN_RVACHEV_OPERATION   Process Rvachev options.
%
% usage
%   [R, k] = ASSIGN_RVACHEV_OPERATION(operation, R1, R2, a)
%
% input
%   operation = selected Boolean operator
%             = 'conjunction' | 'and' | 'intersection' | '&&' | '&' |
%             = 'disjunction' | 'or' | 'union' | '||' | '|' |
%             = 'negation' | 'not' | 'complement' | '!' | '~' |
%             = 'equivalence'
%   R1 = first operand
%   R2 = second operand
%   a = parameter(s) of selected Rvachev operation
%     \in (-1,1] |
%     [a, m] (a\in(-1,1] and m = even positive integer) | 
%       p = even positive integer
%
% output
%   R = negated R1 if negation, otherwise empty
%   k = selected sign in Rvachev operations
%
% See also RVACHEV, GRAD_RVACHEV.
%
% File:      assign_rvachev_operation.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.09.11
% Language:  MATLAB R2011a
% Purpose:   process Rvachev options
% Copyright: Ioannis Filippidis, 2011-

switch operation
    case {'xnor', 'equivalence'}
        if (rem(a,2) ~= 0) || (a <= 0)
            error('Parameter p value is not an even positive integer.')
        end
        R = sign(R1) .*sign(R2) .*(R1.^a +R2.^a).^(-1/a);
    case {'not', 'complement', '!', '~'}
        R = -R1;
    case {'or', 'union', 'disjunction', '||', '|'}
        k = +1;
        R = [];
    case {'and', 'intersection', 'conjunction', '&&', '&'}
        k = -1;
        R = [];
    otherwise
        error( ['Unknown operation on Rvachev functions. '...
            'Valid operations are: '...
            '''complement'', ''union'', ''intersection''.'] )
end
