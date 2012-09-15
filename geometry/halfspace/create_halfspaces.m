function [halfspaces] = create_halfspaces(qp, n, domains, pred)
%CREATE_HALFSPACES  Initialize multiple halfspace structures.
%
% usage
%   hafspaces = CREATE_HALFSPACES(qp, n, domains)
%   hafspaces = CREATE_HALFSPACES(qp, n, domains, pred)
%
% input
%   qp = point in plane separating the two half-spaces
%      = [#dim x #halfspaces]
%   n = vector normal to defining (hyper)plane,
%       oriented towards the interior of the half-space
%     = [#dim x #halfspaces]
%   domains = extent to which the half-space is plotted
%
% output
%   halfspaces = array of halfspace structures
%
% See also create_halfspace, beta_halfspaces, plot_halfspaces.
%
% File:      create_halfspaces.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.12.25 - 
% Language:  MATLAB R2011b
% Purpose:   initializes multiple half-spaces
% Copyright: Ioannis Filippidis, 2011-

nobs = size(qp, 2);

if ~isequal(size(n), size(qp) )
    error('n does not correspond to the size of qp.')
end

if nargin < 3
    domains = repmat({[-1, 1, -1, 1] }, 1, nobs);
end

if nargin < 4
    pred = repmat({''}, 1, nobs);
end

halfspaces = struct('qp', zeros(0, nobs), 'n', [], 'domain', [], 'predicate', '' ).';
for i=1:nobs
    curqp = qp(:, i);
    curn = n(:, i);
    curdomain = domains{1, i};
    curpred = pred{1, i};
    
    halfspaces(i, 1) = create_halfspace(curqp, curn, curdomain, curpred);
end
