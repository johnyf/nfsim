function [varargout] = plot_ellipsoid(ax, xc, R, A, npnt)
%PLOT_ELLIPSOID     ellipsoid or ellipse plot
%   AX = axis handle for plot
%   XC = ellipsoid center = [#dim x 1]
%   R = rotation matrix = [#dim x #dim]
%   A = ellipsoid definition matrix (positive semi-definite)
%     = [#dim x #dim]
%   NPNT = number of points around ellipse (resolution) >0
%
% File:      draw_ellipsoid.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.02.10 - 2011.09.10
% Language:  MATLAB R2011a
% Purpose:   plot an ellipsoid
% Copyright: Ioannis Filippidis, 2011-

%% check args
if isempty(ax)
    ax = gca;
end

if nargin == 4
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
    [x, y] = drawEllipse(0, 0, D(1,1), D(2,2) ); % David Legland's
    
    XY = R *V *[x; y];
    XY = bsxfun(@plus, XY, xc);
end

% 3D case
if ndim == 3
    [x, y, z] = ellipsoid(0, 0, 0, D(1,1), D(2,2), D(3,3), npnt);
    
    for i=1:numel(x)
        XYZ = R *V *[x(i), y(i), z(i) ]' +xc;
        
        x(i) = XYZ(1,1);
        y(i) = XYZ(2,1);
        z(i) = XYZ(3,1);
    end
end

%% only output wanted?
if nargout > 0
    % 2D case
    varargout{1} = XY;

    if ndim == 3
        varargout{1} = XYZ;
    end
    return
end

%% plot
if ndim == 2
    plot(ax, XY(1,:), XY(2,:) )
elseif ndim == 3
    surf(ax, x, y, z)
else
    error('ndim ~= 2, 3.')
end
