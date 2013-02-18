function [h] = krf2gradfield(ax, X, Y, krf)
% plot scalar field negated gradient field
%
% 2010.09.30 - 2012.01.22 (c) Ioannis Filippidis, jfilippidis@gmail.com
%
% See also QUIVER_KRF, DOMAIN2GRAD_KRF.

dx = X(1, 2) -X(1, 1);
dy = Y(2, 1) - Y(1, 1);

dx = abs(dx);
dy = abs(dy);

[px, py] = gradient(krf, dx, dy);

h = quiver(ax, X, Y, -px, -py);
