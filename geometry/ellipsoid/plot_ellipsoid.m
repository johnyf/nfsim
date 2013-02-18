function [varargout] = plot_ellipsoid(ax, xc, rot, A, npnt, varargin)
%PLOT_ELLIPSOID     Ellipsoid or ellipse plot.
%
% usage
%   [q, x, y, z] = PLOT_ELLIPSOID(ax, xc, rot, A, npnt, varargin)
% 
% input
%   ax = axis handle for plot
%   xc = ellipsoid center = [#dim x 1]
%   rot = rotation matrix = [#dim x #dim]
%   A = ellipsoid definition matrix (positive semi-definite)
%     = [#dim x #dim]
%   npnt = number of points around ellipse (resolution) >0
%   varargin = options passed to plot or surf
%
% output
%   q = points on ellipse
%   X = matrix of x coordinates of points on ellipsoid
%   Y = matrix of y coordinates of points on ellipsoid
%   Z = matrix of z coordinates of points on ellipsoid
%
% See also PARAMETRIC_ELLIPSE.
%
% File:      plot_ellipsoid.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.02.10 - 2012.01.24
% Language:  MATLAB R2011b
% Purpose:   plot an ellipsoid
% Copyright: Ioannis Filippidis, 2011-

% depends
%   drawEllipse, ellipsoid
%   check_ellipsoid, meshgrid2vec, vec2meshgrid, plotmd

%% check args
if isempty(ax)
    ax = gca;
end

if nargin < 5
    npnt = 100;
end

check_ellipsoid(A)
ndim = size(A, 1);

%% calculations
[V, D] = eig(A);
D = (1./D).^0.5;

%% graphics calculation

% 2D case
if ndim == 2
    [X, Y] = drawEllipse(0, 0, D(1,1), D(2,2), 0, npnt); % David Legland's
    
    q = rot *V *[X; Y];
    q = bsxfun(@plus, q, xc);
    
    %X = q(1, :);
    %Y = q(2, :);
    %Z = zeros(1, size(q, 2) );
end

% 3D case
if ndim == 3
    [X, Y, Z] = ellipsoid(0, 0, 0, D(1,1), D(2,2), D(3,3), npnt);
    
    q = meshgrid2vec(X, Y, Z);
    q = rot *V *q;
    q = bsxfun(@plus, q, xc);
    res = size(X);
    %[X, Y, Z] = vec2meshgrid(q, X);
end

%% plot
if ndim == 2
    h = plotmd(ax, q, varargin{:} );
elseif ndim == 3
    h = vsurf(ax, q, 'scaled', res, varargin{:} );
else
    error('ndim ~= 2, 3.')
end

%% output wanted?
if nargout > 0
    varargout{1} = h;
end
