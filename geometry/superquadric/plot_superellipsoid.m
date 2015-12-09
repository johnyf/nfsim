function [] = plot_superellipsoid(ax, xc, a, epsilon, R, npnt, varargin)
%
% usage
%   PLOT_SUPERELLIPSOID(ax, qc, a, e, R, varargin)
%
% input
%   ax = axes handle
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
%   e = epsilons
%   R = major radius
%   varargin = options passed to surf
%
% File:      plot_superellipsoid.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.09.11 - 2012.09.12
% Language:  MATLAB R2011a
% Purpose:   plot superquadric(s) (uses parametric equations)
% Copyright: Ioannis Filippidis, 2011-

%% check args
if isempty(ax)
    fig = figure;
    ax = axes('Parent', fig);
end

% epsilon
if size(epsilon, 1) ~= 2
    error('EPSILON needs to be [2 x #superquadrics.')
end

nsuperellipsoids = size(epsilon, 2);

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
        R = eye(3);
    else
        R = repmat({eye(3) }, 1, nsuperellipsoids);
    end
end

if iscell(R)
    if size(R, 1) ~= nsuperellipsoids
        error('Number of rotation matrices does not match obstacles.')
    end
else
    if nsuperellipsoids ~= 1
        error('Single rotation matrix R provided for multiple obstacles.')
    end
    
    if ~isequal(size(R), [3, 3] )
        error('Rotation matrix R should be [3 x 3].')
    end
end

if nargin < 6
    npnt = 25;
end

%% parameters
etamax = pi/2;
etamin = -pi/2;
wmax = pi;
wmin = -pi;

dom = [etamin, etamax, wmin, wmax];
res = [npnt, npnt+1];
u = domain2vec(dom, res);

for i=1:nsuperellipsoids
    curxc = xc(:, i);
    curepsilon = epsilon(:, i);
    cura = a(:, i);
    
    if iscell(R)
        curR = R{1, i};
    else
        curR = R;
    end
    
    q = parametric_superellipsoid(u, curxc, cura, curepsilon, curR);
    
    vsurf(ax, q, 'scaled', res, varargin{:} )
end
