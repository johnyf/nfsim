function [] = plot_halfspaces(ax, halfspaces, npnt, domain)
%
% See also PLOT_HALFSPACE, BETA_HALFSPACES.

nhalfspaces = size(halfspaces, 1);

for i=1:nhalfspaces
    qp = halfspaces(i, 1).qp;
    n = halfspaces(i, 1).n;
    plot_halfspace(ax, qp, n, npnt, domain)
end
