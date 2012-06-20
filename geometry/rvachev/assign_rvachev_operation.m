function [R, k] = assign_rvachev_operation(operation, R1, R2, a)
%ASSIGN_RVACHEV_OPERATION   Process Rvachev options.
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
    case {'not', 'complement'}
        R = -R1;
    case {'or', 'union', 'disjunction', '||'}
        k = +1;
        R = [];
    case {'and', 'intersection', 'conjunction', '&&'}
        k = -1;
        R = [];
    otherwise
        error( ['Unknown operation on Rvachev functions. '...
            'Valid operations are: '...
            '''complement'', ''union'', ''intersection''.'] )
end
