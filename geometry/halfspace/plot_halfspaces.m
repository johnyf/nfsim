function [] = plot_halfspaces(ax, halfspaces, npnt, domain)
nhalfspaces = size(halfspaces, 1);

for i=1:nhalfspaces
    qp = halfspaces(i, 1).qp;
    n = halfspaces(i, 1).n;
    plot_halfspace(ax, qp, n, npnt, domain)
end
