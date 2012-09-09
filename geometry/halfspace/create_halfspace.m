function [halfspace] = create_halfspace(qp, n, domain, pred)
%CREATE_HALFSPACE   Initialize halfspace structure.
%
% usage
%   halfspace = CREATE_HALFSPACE(qp, n, domain)
%
% inputs
%   qp = point on separating (hyper)plane
%      = [#dim x 1]
%   n = vector normal to defining (hyper)plane,
%       oriented towards the interior of the half-space
%     = [#dim x 1]
%   domain = extent to which the half-space is plotted (as coordinates
%            within the half-space slice)
%          = [xmin, xmax] | %(for 2D)
%          = [xmin, xmax, ymin, ymax] %(for 3D)
%
% output
%   halfspace = structure of half-space parameters
%
% See also create_halfspaces, beta_halfspace, plot_halfspace.
%
% File:      create_halfspace.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.12.25 - 
% Language:  MATLAB R2011b
% Purpose:   initializes a half-space, given its geometric parameters
% Copyright: Ioannis Filippidis, 2011-

if nargin < 4
    pred = '';
end

halfspace = struct('qp', qp, 'n', n, 'domain', domain, 'predicate', pred);
