function [ellipsoid] = create_ellipsoid(qc, rot, r_or_A, pred)
%CREATE_ELLIPSOID   Initialize ellipsoid structure.
%
% usage
%   ellipsoid = CREATE_ELLIPSOID
%   ellipsoid = CREATE_ELLIPSOID(qc, rot, r_or_A, pred)
%
% inputs
%   qc = ellipsoid center
%      = [#dim x 1]
%   rot = ellipsoid axes rotation matrix
%       = [#dim x #dim]
%   r_or_A = ellipsoid radii or matrix defining quadratic form whose
%            level set at value 1 is the ellipsoid, i.e., x.' *A *x = 1
%     = [1 x #dim] | [#dim x #dim]
%   pred = names of predicate
%        = string
%
% output
%   ellipsoid = structure of quadric parameters, with fields:
%       ellipsoid.qc = center
%       ellipsoid.rot = rotation matrix
%       ellipsoid.A = ellipsoid definition matrix
%
% 2011.11.29 (c) Ioannis Filippidis, jfilippidis@gmail.com
%
% See also create_ellipsoids, beta_ellipsoid, plot_ellipsoid.

%% input
if nargin < 1
    qc = zeros(3, 1);
end

if nargin < 2
    rot = [];
end

if isempty(rot)
    ndim = size(qc, 1);
    rot = eye(ndim);
end

if nargin < 3
    r_or_A = [];
end

if isempty(r_or_A)
    ndim = size(qc, 1);
    r_or_A = ones(1, ndim);
end

if nargin < 4
    pred = '';
end

%% output

% radii or matrix A ?
if isvector(r_or_A)
    A = radii2ellipsoid(r_or_A);
else
    A = r_or_A;
end

ellipsoid = struct('qc', qc, 'rot', rot, 'A', A, 'predicate', pred);
