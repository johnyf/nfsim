function [bi, Dbi, D2bi] = beta_halfspace(x, xp, n)
% [bi, Dbi, D2bi] = beta_halfspace(x, xp, n)
%
% input
%   x = calculation points
%     = [#dimensions x #points]
%   xp = point on dividing (hyper)plane
%     = [#dimensions x 1]
%   n = normal vectors to dividing (hyper)plane
%
% output
%   bi = scalar obstacle function
%      = [1 x 1]
%   Dbi = obstacle function gradient at calculation points
%      = [#dimensions x #points]
%   D2bi = obstacle function Hessian matrices at calculation points
%      = {1 x #points}
%
% See also BETA_HALFSPACES.
%
% File:      beta_halfspace.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.12.25
% Language:  MATLAB R2011b
% Purpose:   implicit \beta_i, \nabla\beta_i, D^2\beta_i for half-space
% Copyright: Ioannis Filippidis, 2011-

bi = ((x -xp)' *n)^2;
Dbi = 2 *((x -xp)' *n) *n;

npnt = size(x, 2);

% caution: fix curvature
D2bi = {eye(3) };
D2bi = repmat(D2bi, 1, npnt);
