function [halfspaces] = add_halfspace(halfspace, halfspaces)
%
% See also ADD_HALFSPACES, CREATE_HALFSPACES.

n = size(halfspaces, 1);
n = n +1;

halfspaces(n, 1).qp = halfspace.qp;
halfspaces(n, 1).n = halfspace.n;
halfspaces(n, 1).domain = halfspace.domain;
