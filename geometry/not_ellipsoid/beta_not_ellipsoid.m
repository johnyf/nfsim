function [bi, Dbi, D2bi] = beta_not_ellipsoid(x, xc, rot, A)
%BETA_NOT_ELLIPSOID     Inwardly oriented quadric, i.e., for 0th obstacle.
%
% usage
%   [bi, Dbi, D2bi] = beta_not_ellipsoid(x, xc, R, A)
%
% input
%   x = calculation points
%     = [#dimensions x #points]
%   xc = quadric reference frame center
%     = [#dimensions x 1]
%   R = rotation matrix
%     = [#dimensions x #dimensions]
%   A = quadric definition matrix
%     = [#dimensions x #dimensions]
%
% output
%   bi = scalar obstacle function
%      = [1 x 1]
%   Dbi = obstacle function gradient at calculation points
%      = [#dimensions x #points]
%   D2bi = obstacle function Hessian matrices at calculation points
%      = {1 x #points}
%
% See also beta_not_ellipsoids, plot_not_ellipsoids, create_not_ellipsoids.
%
% File:      beta_not_ellipsoid.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.09.10 - 2011.11.29
% Language:  MATLAB R2011b
% Purpose:   implicit \beta_i and \nabla\beta_i for 0th obstacle
% Copyright: Ioannis Filippidis, 2011-

x = rot.' *bsxfun(@minus, x, xc);

bi = 1 -dot(x, A *x, 1);

Dbi = -2 *A *x;
Dbi = rot *Dbi;

npnt = size(x, 2);

D2bi = -2 *A;
D2bi = rot *D2bi *rot.';
D2bi = {D2bi};
D2bi = repmat(D2bi, 1, npnt);
