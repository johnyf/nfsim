function [halfspaces] = add_halfspace(halfspace, halfspaces)
n = size(halfspaces, 1);
n = n +1;

halfspaces(n, 1).qp = halfspace.qp;
halfspaces(n, 1).n = halfspace.n;
