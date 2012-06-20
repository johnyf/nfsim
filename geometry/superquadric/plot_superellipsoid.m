function [] = plot_superellipsoid(ax, qc, a, e, R, varargin)
% input
%   ax = axes handle
%   qc = superellipsoid center
%   e = exponents
%     = [3 x #superquadrics]
%     = [e11, e12, e13, ...;
%        e21, e22, e23, ...;
%        e31, e32, e33, ...]
%   a = semi-radii
%     = [3 x #superqudrics]
%     = [a11, a12, a13, ...;
%        a21, a22, a23, ...;
%        a31, a32, a33, ...]
%   e = epsilons
%   R = major radius
%   varargin = options passed to surf
%
% File:      plot_superellipsoid.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.09.11
% Language:  MATLAB R2011a
% Purpose:   plot superquadric(s) (uses parametric equations)
% Copyright: Ioannis Filippidis, 2011-

xc = qc;
epsilon = e;

%% check args
if isempty(ax)
    fig = figure;
    ax = axes('Parent', fig);
end

% epsilon
if size(epsilon, 2) ~= 2
    error('EPSILON needs to be [2 x #superquadrics.')
end

nsuperellipsoids = size(epsilon, 1);

% a
if size(a, 2) ~= 3
    error('A needs to be [3 x #superquadrics.')
end

if ~isequal(nsuperellipsoids, size(a, 1) )
    error(['Different number of superquadrics (columns) ',...
          'provided in EPSILON and A.'] )
end

% xc
if nargin < 4
    if nsuperellipsoids == 1
        xc = zeros(3, 1);
    else
        xc = repmat({zeros(3, 1) }, nsuperellipsoids, 1);
    end
end

if iscell(xc)
    if size(xc, 1) ~= nsuperellipsoids
        error('Number of origins XC different than obstacles.')
    end
else
    if nsuperellipsoids ~= 1
        error('Single origin XC provided for multiple obstacles.')
    end
    
    if ~isequal(size(xc), [3, 1] )
        error('Single origin XC is not of dimension [3 x 1].')
    end
end

% R
if nargin < 5
    if nsuperellipsoids == 1
        R = eye(3);
    else
        R = repmat({eye(3) }, nsuperellipsoids, 1);
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

%% parameters
n = 50;
etamax = pi/2;
etamin = -pi/2;
wmax = pi;
wmin = -pi;

deta = (etamax -etamin) /n;
dw = (wmax -wmin) /n;

[i, j] = meshgrid(1:n+1, 1:n+1);
eta = etamin +(i -1) *deta;
w = wmin +(j -1) *dw;

ce = cos(eta);
se = sin(eta);
cw = cos(w);
sw = sin(w);

for i=1:nsuperellipsoids
    curepsilon = epsilon(i, :);
    cura = a(i, :);
    
    if iscell(R)
        curxc = xc{i, 1};
        curR = R{i, 1};
    else
        curxc = xc;
        curR = R;
    end
    
    calculate_plot_single_superquadric(ax, curepsilon, cura, curxc, curR,...
                                       ce, se, cw, sw, varargin{:} )
end

function [] = calculate_plot_single_superquadric(ax, e, a,...
                                            xc, R, ce, se, cw, sw, varargin)
x = a(1) .*sign(ce) .*abs(ce).^e(1)...
         .*sign(cw) .*abs(cw).^e(2);
y = a(2) .*sign(ce) .*abs(ce).^e(1)...
         .*sign(sw) .*abs(sw).^e(2);
z = a(3) .*sign(se) .*abs(se).^e(1);

[n, m] = size(x);

% rotate
q = [x(:), y(:), z(:) ].';
q = R *q;

% translate origin
q = bsxfun(@plus, q, xc);

%% plot
x = q(1, :);
y = q(2, :);
z = q(3, :);

x = reshape(x, m, n);
y = reshape(y, m, n);
z = reshape(z, m, n);

mesh(ax, x, y, z, varargin{:} )
