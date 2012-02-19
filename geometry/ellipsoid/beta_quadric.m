function [bi, Dbi, D2bi] = beta_quadric(x, xc, rot, A)
% [bi, Dbi, D2bi] = beta_quadric(x, xc, rot, A)
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
% See also BETA_QUADRICS.
%
% File:      beta_quadric_inward.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.09.10 - 2011.11.26
% Language:  MATLAB R2011b
% Purpose:   implicit \beta_i, \nabla\beta_i, D^2\beta_i for
%            ellipsoid, one-sheet hyperboloid, cylinder
% Copyright: Ioannis Filippidis, 2011-

x = rot.' *bsxfun(@minus, x, xc);

bi = dot(x, A *x, 1) -1;

Dbi = 2 *A *x;
Dbi = rot *Dbi;

npnt = size(x, 2);

D2bi = 2 *A;
D2bi = rot *D2bi *rot.';
D2bi = {D2bi};
D2bi = repmat(D2bi, 1, npnt);
