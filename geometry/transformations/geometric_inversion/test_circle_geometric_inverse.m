function [] = test_circle_geometric_inverse
% 2013.01.25 Copyright Ioannis Filippidis
%
% See also circle_geometric_inverse, geometric_inversion.

cla

% inversion circle
x0 = origin(2);
r0 = 1;

% circle to invert
x = [1, 1.7].';
r = 2;

% image under inversion
[xi, ri] = circle_geometric_inverse(x, r, x0, r0);

ax = gca;
    hold(ax, 'on')
plot_circle(ax, x0, r0, 'b')
plot_circle(ax, x, r, 'g--')
plot_circle(ax, xi, ri, 'r-o')

plotidy(ax)
axis(ax, 'equal')
