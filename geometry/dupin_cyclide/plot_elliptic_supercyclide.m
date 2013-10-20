function [h] = plot_elliptic_supercyclide(ax, qc, R, rm, dr, rot, q0, varargin)
%PLOT_ELLIPTIC_SUPERCYCLIDE     Plot elliptic supercyclide.
%
% usage
%   PLOT_ELLIPTIC_SUPERCYCLIDE(ax, qc, R, rm, dr)
%   PLOT_ELLIPTIC_SUPERCYCLIDE(ax, qc, R, rm, dr, rot, q0, varargin)
%
% input
%   ax = axes object handle
%   qc = center of elliptic supercyclide
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
%   varargin = options passed to surf
%
% Note
%   There are two definition/computation alternatives:
%       1) Directly using a center, rotation and parameters.
%          This is easier because it is direct.
%          Moreover, this involves fewer numerical operations.
%
%       2) Indirectly using the inversion of a torus.
%          This requires definition of both the torus and the inversion,
%          which is more complicated and demanding.
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
% See also PLOT_DUPIN_CYCLIDE_USING_INVERSION, BETA_SUPERCYCLIDE,
%          EXAMPLE_DUPIN_CYCLIDE, example_supercyclide.
%
% File:      plot_elliptic_supercyclide.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.05.19
% Language:  MATLAB R2012a
% Purpose:   Plot an elliptic sypercyclide defined by parameters
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

% axes ?
if isempty(ax)
    ax = gca;
end

% rotated axes ?
if nargin < 6
    rot = eye(3);
elseif isempty(rot)
    rot = eye(3);
end

% scaled supercyclide ?
if nargin < 7
    q0 = ones(3, 1);
elseif isempty(q0)
    q0 = ones(3, 1);
end

x0 = q0(1, 1);
y0 = q0(2, 1);
z0 = q0(3, 1);

b = sqrt(a^2 -c^2);

%% calc
domain = [0, 2*pi, 0, 2*pi]; % \theta, \psi
resolution = [30, 35];

[uv, U, ~] = domain2vec(domain, resolution);

u = uv(1, :);
v = uv(2, :);

q = [x0*(m *(c -a .*cos(u) .*cos(v) ) +b^2 .*cos(u) );
     y0*(b *sin(u) .*(a -m *cos(v) ) );
     z0*(b *sin(v) .*(c *cos(u) -m) ) ];

c = a -c *cos(u) .*cos(v);

q = bsxfun(@rdivide, q, c);
            
q = bsxfun(@plus, q, qc);

[X, Y, Z] = vec2meshgrid(q, U);

h = surf(ax, X, Y, Z, varargin{:} );
