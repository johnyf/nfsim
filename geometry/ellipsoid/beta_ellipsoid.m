function [bi, Dbi, D2bi] = beta_ellipsoid(x, xc, rot, A)
% Quadratic obstacle function for single ellipsoid.
%
% usage
%   [bi, Dbi, D2bi] = BETA_ELLIPSOID(x, xc, rot, A)
%
% input
%   x = calculation points
%     = [#dimensions x #points]
%   xc = quadric reference frame center
%     = [#dimensions x 1]
%   rot = rotation matrix
%     = [#dimensions x #dimensions]
%   A = quadric definition matrix, representing:
%       ellipsoid, one-sheet hyperboloid, cylinder
%     = [#dimensions x #dimensions]
%
% output
%   bi = scalar obstacle function
%      = [1 x #points]
%   Dbi = obstacle function gradient at calculation points
%      = [#dimensions x #points]
%   D2bi = obstacle function Hessian matrices at calculation points
%      = {1 x #points}
%
% 2011.09.10 - 2011.11.26 (c) Ioannis Filippidis, jfilippidis@gmail.com
%
% See also beta_ellipsoids, plot_ellipsoid, create_ellipsoid.

%% input
if nargin < 2
    disp('No ellipsoid center provided: using origin.')
    ndim = size(x, 1);
    xc = zeros(ndim, 1);
end

if nargin < 3
    disp('No rotation matrix provided: using identity.')
    ndim = size(x, 1);
    rot = eye(ndim);
end

if nargin < 4
    disp('No ellipsoid defining matrix A provided: using identity.')
    ndim = size(x, 1);
    A = eye(ndim);
end

%% calc

x = rot.' *bsxfun(@minus, x, xc);

bi = dot(x, A *x, 1) -1;

Dbi = 2 *A *x;
Dbi = rot *Dbi;

npnt = size(x, 2);

D2bi = 2 *A;
D2bi = rot *D2bi *rot.';
D2bi = {D2bi};
D2bi = repmat(D2bi, 1, npnt);
