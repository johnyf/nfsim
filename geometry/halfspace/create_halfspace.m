function [halfspace] = create_halfspace(qp, n)
%CREATE_HALFSPACE   initialize halfspace structure
%
% inputs
%   qp = point on separating (hyper)plane
%      = [#dim x 1]
%   n = vector normal to defining (hyper)plane,
%       oriented towards the interior of the half-space
%
% output
%   halfspace = structure of half-space parameters
%
% See also CREATE_HALFSPACES, CREATE_QUADRIC, CREATE_TORUS.
%
% File:      create_halfspace.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.12.25 - 
% Language:  MATLAB R2011b
% Purpose:   initializes a half-space, given its geometric parameters
% Copyright: Ioannis Filippidis, 2011-

halfspace.qp = qp;
halfspace.n = n;
