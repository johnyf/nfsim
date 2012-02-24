function [] = plot_cylinder(ax, qc, n, h, r)
%todo: align with n

[X, Y, Z] = cylinder(r);
X = X +qc(1, :);
Y = Y +qc(2, :);
Z = (h *Z) +qc(3, :);

surf(ax, X, Y, Z)
