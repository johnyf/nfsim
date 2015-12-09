function [bi, Dbi, D2bi] = beta_supercyclide(q, qc, R, rm, dr, rot, q0)
%BETA_SUPERCYCLIDE     Implicit obstacle function for Dupin cyclide.
%   BETA_SUPERCYCLIDE(q, qc, R, rm, dr, rot, q0) plots a Dupin cyclide
%   centered at point qc, with major radius R, mean radius rm and radius
%   semi-difference dr. The Dupix axes of symmetry may be rotated with
%   respect to global coordinates, as defined by the rotation matrix rot.
%
%   For an elliptic supercyclide, vector q0 = [x0, y0, z0].' = [3 x 1]
%   defines the scaling of the semi-radii.
%
% usage
%   BETA_SUPERCYCLIDE(q, qc, R, rm, dr)
%   BETA_SUPERCYCLIDE(q, qc, R, rm, dr, rot)
%   BETA_SUPERCYCLIDE(q, qc, R, rm, dr, rot, q0)
%
% input
%   q = points of function computation
%     = [3 x #points]
%   qc = center of supercyclide
%      = [3 x 1] = [xc, yc, zc].'
%   R = major radius
%     > 0
%   rm = mean minor radius, between the two principal circles
%      > 0
%   dr = minor radius semi-difference, between the two principal circles
%      > 0 and <=R
%
% optional input
%   rot = rotation matrix of the symmetry axes with respect to global coor
%       = [3 x 3] \in SO(3)
%   q0 = vector of scaling factors for each axis, for elliptic supercyclide
%      = [3 x 1] = [x0, y0, z0].'
%
% output
%   bi = obstacle function values at computation points q
%      = [1 x #points]
%   Dbi = obstacle function gradients at computation points q
%       = [3 x #points]
%   D2bi = obstacle function Hessian matrices at computation points q
%        = {1 x #points]
%        = {[3 x 3], [3 x 3], ..., [3 x 3] }
%
% references
%   [1] Foufou S.; Garnier L.
%           "Obtainment of Implicit Equations of Supercyclides and
%            Definition of Elliptic Supercyclides,"
%       Machine Graphics & Vision, Vol.2, No.14, pp. 123 -- 144, 2005
%
%   [2] Foufou S.; Garnier L.
%           "Dupin Cyclide Blends between Quadric Surfaces for Shape
%            Modeling,"
%       Eurographics, Vol.23, No.3, pp. 321--330, 2004
%
% See also PLOT_ELLIPTIC_SUPERCYCLIDE, PLOT_DUPIN_CYCLIDE_USING_INVERSION,
%          EXAMPLE_DUPIN_CYCLIDE, example_supercyclide.
%
% File:      beta_supercyclide.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.02.19 - 2012.05.19
% Language:  MATLAB R2012a
% Purpose:   Elliptic Supercyclide obstacle function & its derivatives
% Copyright: Ioannis Filippidis, 2012-

%% input
% deal params
a = R;
m = rm;
c = dr;

% proper parameters ?
if a < c
    warning('cyclide:params', 'Cyclide parameters should be: dr <= R.')
end

% aligned axes ?
if nargin < 6
    rot = eye(3);
end

% elliptic supercyclide ?
if nargin < 7
    q0 = ones(3, 1);
elseif isempty(q0)
    q0 = ones(3, 1);
end

%% prepare
npnt = size(q, 2);

qi = rot.' *bsxfun(@minus, q, qc); % homogenous transform
qi0 = bsxfun(@rdivide, qi, q0); % scale

[x, y, z] = vec2meshgrid(qi0, qi0(1, :) );

x0 = q0(1, 1);
y0 = q0(2, 1);
z0 = q0(3, 1);

nqi2 = vnorm(qi0, 1, 2).^2;
%b = sqrt(a^2 -c^2);
b2 = a^2 -c^2;
D = nqi2 -m^2 +b2;

%% calculate
bi(1, :) = D.^2 -4 *(a *x -c *m).^2 -4 *b2 *y.^2;
%bi(bi <= 0) = 0;

Dbi(:, 1:npnt) = 4 .*[(x /x0^2 .*D -2 *a /x0 .*(a .*x /x0 -c *m) );
                      (y /y0^2 .*D -2 *b2 /y0^2 .*y);
                      (z /z0^2 .*D) ];
Dbi = rot *Dbi; % pull it back from the aligned system

a1 = 4 /x0^2 .*D +8 /x0^4 .*x.^2 -8 *a^2 /x0^2;
a2 = 8 .*x .*y /(x0 *y0)^2;
a3 = 8 .*x .*z /(x0 *z0)^2;
a4 = 8 .*x .*y /(x0 *y0)^2;
a5 = 4 /y0^2 .*D +8 /y0^4 .*y.^2 -8 *b2 /y0^2;
a6 = 8 .*y .*z /(y0 *z0)^2;
a7 = 8 .*x .*z /(x0 *z0)^2;
a8 = 8 .*y .*z /(y0 *z0)^2;
a9 = 4 /z0^2 .*D +8 /z0^4 .*z.^2;

D2bi = cell(1, npnt);
for i=1:npnt    
    curD2bi = [a1(1, i), a2(1, i), a3(1, i);
               a4(1, i), a5(1, i), a6(1, i);
               a7(1, i), a8(1, i), a9(1, i) ];
    
    curD2bi = rot *curD2bi *rot.';
    D2bi{1, i} = curD2bi;
end
