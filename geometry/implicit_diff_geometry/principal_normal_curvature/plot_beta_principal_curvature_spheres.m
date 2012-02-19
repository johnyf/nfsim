function [] = plot_beta_principal_curvature_spheres(ax, x, obstacles)
%
% See also PLOT_BETA_PRINCIPAL_CURVATURE_CIRCLES,
%      PLOT_IMPLICIT_PRINCIPAL_CURVATURE_SPHERES.

[bi, Dbi, D2bi] = beta_heterogenous(x, obstacles);
[~, Db, D2b] = biDbiD2bi2bDbD2b(bi, Dbi, D2bi);

idx = isnan(Db(1, :) );

x(:, idx) = [];
Db(:, idx) = [];
D2b(:, idx) = [];

plot_implicit_principal_curvature_spheres(ax, x, Db, D2b)