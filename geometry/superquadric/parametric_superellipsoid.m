function [q] = parametric_superellipsoid(u, xc, a, e, rot)
%
% usage
%   PARAMETRIC_SUPERELLIPSOID(u, qc, a, e, R)
%
% input
%   u = vector of surface parameters
%   qc = superellipsoid center
%   e = exponents
%     = [#superquadrics x 2]
%     = [e11, e12;
%        e21, e22;
%        e31, e32]
%   a = semi-radii
%     = [#superqudrics x 3]
%     = [a11, a12, a13;
%        a21, a22, a23; ;;;
%        a31, a32, a33]
%   R = major radius
%
% File:      parametric_superellipsoid.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.09.11 (copied part of plot_superellipsoid)
% Language:  MATLAB R2011a
% Purpose:   parametric equations of superquadric
% Copyright: Ioannis Filippidis, 2011-

%% check args

% epsilon
if size(e, 1) ~= 2
    error('EPSILON needs to be [2 x #superquadrics.')
end

nsuperellipsoids = size(e, 2);

% a
if size(a, 1) ~= 3
    error('A needs to be [3 x #superquadrics.')
end

if ~isequal(nsuperellipsoids, size(a, 2) )
    error(['Different number of superquadrics (columns) ',...
          'provided in EPSILON and A.'] )
end

% xc
if nargin < 4
    if nsuperellipsoids == 1
        xc = zeros(3, 1);
    else
        xc = zeros(3, nsuperellipsoids);
    end
end

if size(xc, 2) ~= nsuperellipsoids
    error('Number of origins XC different than obstacles.')
end

% R
if nargin < 5
    if nsuperellipsoids == 1
        rot = eye(3);
    else
        rot = repmat({eye(3) }, 1, nsuperellipsoids);
    end
end

if iscell(rot)
    if size(rot, 1) ~= nsuperellipsoids
        error('Number of rotation matrices does not match obstacles.')
    end
else
    if nsuperellipsoids ~= 1
        error('Single rotation matrix R provided for multiple obstacles.')
    end
    
    if ~isequal(size(rot), [3, 3] )
        error('Rotation matrix R should be [3 x 3].')
    end
end

%% parameters
eta = u(1, :);
w = u(2, :);

ce = cos(eta);
se = sin(eta);
cw = cos(w);
sw = sin(w);

x = a(1) .*sign(ce) .*abs(ce).^e(1)...
         .*sign(cw) .*abs(cw).^e(2);
y = a(2) .*sign(ce) .*abs(ce).^e(1)...
         .*sign(sw) .*abs(sw).^e(2);
z = a(3) .*sign(se) .*abs(se).^e(1);

q = [x; y; z];
q = local2global_cart(q, xc, rot);
