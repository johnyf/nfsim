function [bi, Dbi, D2bi] = beta_halfspace(x, xp, n)
% [bi, Dbi, D2bi] = beta_halfspace(x, xp, n)
%
% usage
%   [bi, Dbi, D2bi] = BETA_HALFSPACE(x, xp, n)
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
%      = [1 x #pnts]
%   Dbi = obstacle function gradient at calculation points
%      = [#dimensions x #pnts]
%   D2bi = obstacle function Hessian matrices at calculation points
%      = {1 x #pnts}
%
% See also beta_halfspaces, plot_halfspace, create_halfspace.
%
% File:      beta_halfspace.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.12.25 - 2012.09.08
% Language:  MATLAB R2012a
% Purpose:   implicit obstacle function and derivatives for half-space
% Copyright: Ioannis Filippidis, 2011-

npnt = size(x, 2);

x_xp = bsxfun(@minus, x, xp);

normal_projection = n.' *x_xp;
%sgn = sign(normal_projection);
%Lproj = abs(normal_projection);

%bi = sgn .*Lproj.^2;
bi = normal_projection;
%Dbi = 2 *bsxfun(@times, Lproj, n);
Dbi = repmat(n, 1, npnt);

%% Hessian
B = null(n.');
rot = [n, B].';

ndim = size(n, 1);

%e = [2, zeros(1, ndim-1) ];
e = zeros(1, ndim);
D2bi = rot.' *diag(e) *rot;

D2bi = {D2bi};
D2bi = repmat(D2bi, 1, npnt);
