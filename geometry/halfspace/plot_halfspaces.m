function [] = plot_halfspaces(ax, halfspaces, npnt)
%
% See also PLOT_HALFSPACE, BETA_HALFSPACES, CREATE_HALFSPACES.

nhalfspaces = size(halfspaces, 1);

held = takehold(ax, 'local');
for i=1:nhalfspaces
    qp = halfspaces(i, 1).qp;
    n = halfspaces(i, 1).n;
    domain = halfspaces(i, 1).domain;
    
    plot_halfspace(ax, qp, n, npnt, domain)
end
restorehold(ax, held)
