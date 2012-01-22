function [] = plot_limit_cycle_potential
x = linspace(-2, 2, 100);
y = linspace(-2, 2, 100);

[X, Y] = meshgrid(x, y);

Z = limit_cycle_potential(X, Y);

surf(X, Y, Z)
