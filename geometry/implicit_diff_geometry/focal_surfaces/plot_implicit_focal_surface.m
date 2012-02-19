function [] = plot_implicit_focal_surface(ax, q, X, grad, Hessian, focal_no)
%
% See also PLOT_BETA_FOCAL_SURFACE, PLOT_IMPLICIT_FOCAL_SURFACES,
%          IMPLICIT_FOCAL_SURFACE.

[X, Y, Z] = implicit_focal_surface(q, X, grad, Hessian, focal_no);
surf(ax, X, Y, Z)
%plot3(ax, X(:).', Y(:).', Z(:).', 'o')
