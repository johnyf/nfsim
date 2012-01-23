function [varargout] = krnf2gradfield(ax, X, Y, nfZ)
% File:      krnf2gradfield.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2010.09.30 - 2012.01.22
% Language:  MATLAB R2011b
% Purpose:   plot scalar field negated gradient field
% Copyright: Ioannis Filippidis, 2010-

dx = X(1, 2) -X(1, 1);
dy = Y(2, 1) - Y(1, 1);

dx = abs(dx);
dy = abs(dy);

[px, py] = gradient(nfZ, dx, dy);

h = quiver(ax, X, Y, -px, -py);

if nargout == 1
    varargout{1, 1} = h;
end
