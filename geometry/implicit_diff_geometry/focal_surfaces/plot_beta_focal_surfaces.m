function [] = plot_beta_focal_surfaces(ax, x, X, obstacles)
%
% See also PLOT_BETA_FOCAL_SURFACE, PLOT_IMPLICIT_FOCAL_SURFACES.

[bi, Dbi, D2bi] = beta_heterogenous(x, obstacles);

%[~, Db, D2b] = biDbiD2bi2bDbD2b(bi, Dbi, D2bi);
Db = Dbi{1};
D2b = D2bi;

idx = isnan(Db(1, :) );

x(:, idx) = [];
Db(:, idx) = [];
D2b(:, idx) = [];

plot_implicit_focal_surfaces(ax, x, X, Db, D2b)