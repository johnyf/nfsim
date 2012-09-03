function [halfspaces] = create_halfspaces(qp, n, domain)
%CREATE_HALFSPACES  Initialize multiple halfspace structures.
%
% usage
%   hafspaces = CREATE_HALFSPACES(qp, n)
%
% input
%   qp = point in plane separating the two half-spaces
%      = [#dim x #halfspaces]
%   n = vector normal to defining (hyper)plane,
%       oriented towards the interior of the half-space
%     = [#dim x #halfspaces]
%
% output
%   halfspaces = array of halfspace structures
%
% See also CREATE_HALFSPACE, BETA_HALFSPACES.

nobs = size(qp, 2);

if ~isequal(size(n), size(qp) )
    error('n does not correspond to the size of qp.')
end

if nargin < 3
    domain = repmat({[-1, 1, -1, 1] }, 1, nobs);
end

halfspaces = struct('qp', zeros(0, nobs), 'n', [], 'domain', [] );
for i=1:nobs
    curqp = qp(:, i);
    curn = n(:, i);
    curdomain = domain{1, i};
    
    halfspaces(i, 1) = create_halfspace(curqp, curn, curdomain);
end
