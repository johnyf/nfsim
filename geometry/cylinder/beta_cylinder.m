function [bi, Dbi, D2bi] = beta_cylinder(q, qc, r, rot)
%BETA_CYLINDER  Single cylinder obstacle function and derivatives.
%
% usage
%   [bi, Dbi, D2bi] = BETA_CYLINDER(q, qc, r, rot)
%
% input
%   q = caluclation points
%     = [3 x #pnts]
%   qc = center of circle at one end of the cylinder
%      = [3 x 1]
%   r = cylinder radius
%     > 0
%   rot = rotation matrix around point qc
%       = [3 x 3] \in SO(3)
%
% output
%   bi = obstacle function
%      = [1 x #pnts]
%   Dbi = gradient of obstacle function
%       = [3 x #pnts]
%   D2bi = Hessian matrix of obstacle function
%        = {1 x #pnts} = {[3 x 3], ... }
%
% 2012.01.02 (c) Ioannis Filippidis, jfilippidis@gmail.com
%
% See also beta_cylinders, plot_cylinder, create_cylinder.

%% input
if nargin < 4
    rot = eye(3);
end

%% calc
npnt = size(q, 2);

qi = global2local_cart(q, qc, rot);

% projection on (x, y) plane
P = eye(3);
P(3, 3) = 0;

qi = P *qi;

R = vnorm(qi, 1, 2);
bi = R.^2 -r^2;

Dbi = 2 *qi;
Dbi = rot *Dbi;

D2bi = 2 *[1, 0, 0; 0, 1, 0; 0, 0, 0];
D2bi = {rot *D2bi *rot.'};
D2bi = repmat(D2bi, 1, npnt);
