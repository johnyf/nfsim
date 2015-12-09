function [cyclide] = create_supercyclide(qc, R, rm, dr, rot, q0, pred)
%CREATE_ELLIPSOID   Initialize ellipsoid structure.
%
% usage
%   [cyclide] = create_supercyclide(qc, R, rm, dr, rot, q0, pred)
%
% inputs
%   qc = center
%      = [#dim x 1]
%   rot = rotation matrix
%       = [#dim x #dim]
%   pred = name of predicate
%        = string
%
% output
%   
%
% 2011.11.29 (c) Ioannis Filippidis, jfilippidis@gmail.com
%
% See also create_ellipsoids, beta_ellipsoid, plot_ellipsoid.

%% input
if nargin < 1
    qc = zeros(3, 1);
end

if nargin < 2
    R = 4;
end

if nargin < 3
    rm = 2;
end

if nargin < 4
    dr = 0.5;
end

if nargin < 5
    rot = eye(3);
end

if isempty(rot)
    ndim = size(qc, 1);
    rot = eye(ndim);
end

if nargin < 6
    q0 = [1, 2, 2].';
end

if nargin < 7
    pred = '';
end

%% output
cyclide = struct('qc', qc, 'R', R, 'rm', rm, 'dr', dr,...
                 'rot', rot, 'q0', q0, 'predicate', pred);
