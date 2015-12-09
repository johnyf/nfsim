function [q, res, X, Y, Z] = parametric_torus(qc, r, R, rot, npnt)
%PARAMETRIC_TORUS   Generate a torus.
%
% usage
%   [q, res, X, Y, Z] = PARAMETRIC_TORUS(qc, r, R, rot, npnt)
%
% input
%   qc = torus center
%      = [3 x 1]
%   r = torus minor radius (lateral radius)
%     > 0
%   R = torus major radius (central radius)
%     > 0
%   rot = rotation matrix
%       \in SO(3)
%   npnt = number of points for the parametric surface
%
% output
%   q = points on torus surface
%     = [3 x (npnt^2/2) ]
%   res = resolution
%       = [npnt, npnt/2]
%   X = meshgrid of abscissas
%     = [npnt x npnt/2]
%   Y = meshgrid of ordinates
%     = [npnt x npnt/2]
%   Z = meshgrid of coordinates
%     = [npnt x npnt/2]
%
% See also plot_torus, plot_tori, beta_torus, create_torus.
%
% File:      plot_torus.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2010.12.05 - 2012.09.02
% Language:  MATLAB R2012a
% Purpose:   generate points on a torus
% Copyright: Ioannis Filippidis, 2010-

%% input
if nargin < 5
    npnt = 30;
end

%% parameterize
n = npnt;
m = ceil(npnt /2);
res = [n, m];

% surface parameterization
theta = pi *linspace(0, 2, n);
phi = 2 *pi *linspace(0, 1, m).';

% vertices
X = (R + r *cos(phi) ) *cos(theta);
Y = (R + r *cos(phi) ) *sin(theta);
Z = r *sin(phi) *ones(size(theta) );

q = meshgrid2vec(X, Y, Z);
q = rot *q;
q = bsxfun(@plus, q, qc);

if nargout < 3
    return
end

[X, Y, Z] = vec2meshgrid(q, X);
