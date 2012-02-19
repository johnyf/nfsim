function [X, Y, Z] = implicit_focal_surface(q, X, grad, Hessian, focal_no)
% also known as principal evolute(s)
% is the locus of principal normal curvature centers
%
% See also PLOT_IMPLICIT_FOCAL_SURFACE,
%          IMPLICIT_PRINCIPAL_CURVATURE_SPHERES.

% focal = evolvent +normals
qc = implicit_principal_curvature_spheres(q, grad, Hessian);

% surface neighbor connectivity info
m = size(qc, 2);
ndim = size(q, 1);
qk = nan(ndim, m);

for i=1:m
    qk(:, i) = qc{1, i}(:, focal_no);
end

qk = 2 *(qk -q) +q;

[X, Y, Z] = vec2meshgrid(qk, X);
