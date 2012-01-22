function [A] = radii2ellipsoid(a)
% convert diagonals to ellipsoid symmetric matrix

A = diag(1 ./a.^2);
