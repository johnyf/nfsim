function [] = plot_implicit_focal_surfaces(ax, q, X, grad, Hessian)
%
% See also PLOT_BETA_FOCAL_SURFACES, PLOT_IMPLICIT_FOCAL_SURFACE.

ndim = size(q, 1);
n = ndim -1;
for focal_no=1:n
    plot_implicit_focal_surface(ax, q, X, grad, Hessian, focal_no)
end
