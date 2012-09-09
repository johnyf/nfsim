function [ellipsoid] = create_ellipsoid(qc, rot, r, pred)
%CREATE_ELLIPSOID   Initialize ellipsoid structure.
%
% usage
%   ellipsoid = CREATE_ELLIPSOID(qc, rot, r)
%
% inputs
%   qc = ellipsoid center
%      = [#dim x 1]
%   rot = ellipsoid axis rotation matrix
%       = [#dim x #dim]
%   r = ellipsoid radii
%     = [1 x #dim]
%
% output
%   ellipsoid = structure of quadric parameters, with fields:
%       ellipsoid.qc = center
%       ellipsoid.rot = rotation matrix
%       ellipsoid.A = ellipsoid definition matrix
%
% See also create_ellipsoids, beta_ellipsoid, plot_ellipsoid.
%
% File:      create_ellipsoid.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.11.29 - 
% Language:  MATLAB R2011b
% Purpose:   initializes an ellipsoid, given its geometric parameters
% Copyright: Ioannis Filippidis, 2011-

%% input
if nargin < 2
    rot = [];
end

if isempty(rot)
    ndim = size(qc, 1);
    rot = eye(ndim);
end

if nargin < 3
    r = [];
end

if isempty(r)
    ndim = size(qc, 1);
    r = ones(1, ndim);
end

if nargin < 4
    pred = '';
end

%% output
A = radii2ellipsoid(r);
ellipsoid = struct('qc', qc, 'rot', rot, 'A', A, 'predicate', pred);
