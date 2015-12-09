function [varargout] = parametric_ellipsoid(u, qc, rot, r)
%PARAMETRIC_ELLIPSOID   Parametric equation of ellipsoid.
%
% usage
%   [q, res] = parametric_ellipsoid
%   [q, res] = parametric_ellipsoid([], qc, rot, r)
%   q = parametric_ellipsoid(u, qc, rot, r)
%
% input (optional)
%   u = vector in parameter space (2d for 2-ellipsoid, 3d for 3-ellipsoid)
%     = angles in rad, e.g. (0-2*pi, 0-pi) for 2-ellipsoid
%     = [2 x #pnts] | [3 x #pnts]
%       if isempty(u), then default u = [0, 2*pi, 0, pi] used
%   qc = ellipsoid center
%      = [#dim x 1]
%   rot = rotation matrix
%       \in SO(2) | \in SO(3)
%   r = ellipsoid semi-radii
%     = [3 x 1] > 0
%
% output
%   q = vector of Cartesian coordinates in ambient space
%     = [#dim x #pnts]
%   res = resolution used (useful if default u used)
%       = [1 x (#dim-1) ]
%
% 2012.09.10 (c) Ioannis Filippidis, jfilippidis@gmail.com
%
% See also parametric_ellipse.

% todo
%   defaults for parameter vectors

% depends
%   local2global_cart

%% input
if nargin < 1
    u = [];
end

% deafult ?
if isempty(u)
    dom = [0, 2*pi, 0, pi];
    res = [30, 15];
    u = dom2vec(dom, res);
else
    res = [];;
end

if nargin < 2
    qc = zeros(3, 1);
end

if nargin < 3
    rot = eye(3);
end

if nargin < 4
    r = ones(1, 3);
end

%% calc
ndim = size(qc, 1);

switch ndim
    case 3
        [q] = param_ellipsoid3d(u, qc, rot, r);
    case 4
        [q] = param_ellipsoid4d(u, qc, rot, r);
    otherwise
        error('3 or 4 dim.')
end

if isempty(res)
    varargout = {q};
else
    varargout = {q, res};
end

function [q] = param_ellipsoid4d(t, qc, rot, r)
a = r(1, 1);
b = r(2, 1);
c = r(3, 1);
d = r(4, 1);

u = t(1, :);
v = t(2, :);
w = t(3, :);

q = [a .*cos(u) .*cos(v) .*cos(w);
     b .*cos(u) .*cos(v) .*sin(w);
     c .*cos(u) .*sin(v);
     d .*sin(u) ];

q = local2global_cart(q, qc, rot);

function [q] = param_ellipsoid3d(t, qc, rot, r)
a = r(1, 1);
b = r(2, 1);
c = r(3, 1);

%t = domain2vec(dom, res);

u = t(1, :);
v = t(2, :);

q = [a .*cos(u) .*sin(v);
     b .*sin(u) .*sin(v);
     c .*cos(v) ];

q = local2global_cart(q, qc, rot);
