function [] = plot_beta_focal_surface(ax, x, X, obstacles, focal_no)
%
% See also PLOT_BETA_FOCAL_SURFACES, PLOT_IMPLICIT_FOCAL_SURFACE.

[bi, Dbi, D2bi] = beta_heterogenous(x, obstacles);

[~, Db, D2b] = biDbiD2bi2bDbD2b(bi, Dbi, D2bi);

idx = isnan(Db(1, :) );

x(:, idx) = [];
Db(:, idx) = [];
D2b(:, idx) = [];

plot_implicit_focal_surface(ax, x, X, Db, D2b, focal_no)