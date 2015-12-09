function [varargout] = unitcircle(n, theta)
% Return unit circle point coordinates
%
%usage
%=====
% [X] = unitcircle(n) % X = [2 x n]
% [x, y] = unitcircle(n) % x = [1 x n], y = [1 x n]
%
%input
%=====
%   n = # pnts [30]
%   theta = [rad] central angle of points [0]
%
%about
%=====
% 2011.09.26 (c) Ioannis Filippidis, jfilippidis@gmail.com
% See also circle, ellipse, plot_ellipsoid, parametric_ellipse.

if nargin < 1
    n = 30;
end

% specific angle given ?
if nargin < 2
    theta = 2*pi *linspace(0, 1, n);
end
unit_circle = [sin(theta); cos(theta)];

if nargout == 1
    varargout{1} = unit_circle;
else
    varargout{1} = unit_circle(1, :);
    varargout{2} = unit_circle(2, :);
end
