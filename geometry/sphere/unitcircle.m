function [varargout] = unitcircle(varargin)
% [X] = unitcircle(n) % X = [2 x n]
% [x, y] = unitcircle(n) % x = [1 x n], y = [1 x n]

if nargin == 0
    n = 30;
else
    n = varargin{1};
end

t = 2*pi *linspace(0, 1, n);
unit_circle = [sin(t); cos(t)];

if nargout == 1
    varargout{1} = unit_circle;
else
    varargout{1} = unit_circle(1, :);
    varargout{2} = unit_circle(2, :);
end
