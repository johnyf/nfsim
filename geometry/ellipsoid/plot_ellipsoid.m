function [q, x, y, z] = plot_ellipsoid(ax, xc, rot, A, npnt)
%PLOT_ELLIPSOID     ellipsoid or ellipse plot
%
% usage
%   [q, x, y, z] = PLOT_ELLIPSOID(ax, xc, rot, A, npnt)
%
%   ax = axis handle for plot
%   xc = ellipsoid center = [#dim x 1]
%   rot = rotation matrix = [#dim x #dim]
%   A = ellipsoid definition matrix (positive semi-definite)
%     = [#dim x #dim]
%   npnt = number of points around ellipse (resolution) >0
%
% File:      plot_ellipsoid.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.02.10 - 2012.01.24
% Language:  MATLAB R2011b
% Purpose:   plot an ellipsoid
% Copyright: Ioannis Filippidis, 2011-

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
    [x, y] = drawEllipse(0, 0, D(1,1), D(2,2), 0, npnt); % David Legland's
    
    q = rot *V *[x; y];
    q = bsxfun(@plus, q, xc);
end

% 3D case
if ndim == 3
    [x, y, z] = ellipsoid(0, 0, 0, D(1,1), D(2,2), D(3,3), npnt);
    
    for i=1:numel(x)
        q = rot *V *[x(i), y(i), z(i) ]' +xc;
        
        x(i) = q(1,1);
        y(i) = q(2,1);
        z(i) = q(3,1);
    end
end

%% only output wanted?
if nargout > 0
    return
end

%% plot
if ndim == 2
    plotmd(ax, q)
elseif ndim == 3
    surf(ax, x, y, z)
else
    error('ndim ~= 2, 3.')
end
