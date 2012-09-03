function [] = plot_beta_focal_surfaces(ax, x, res, obstacles)
%
% See also PLOT_BETA_FOCAL_SURFACE, PLOT_IMPLICIT_FOCAL_SURFACES.
%
% File:      plot_beta_focal_surfaces.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.02.19
% Language:  MATLAB R2012a
% Purpose:   plot focal surface sheets of implicitly defined obstacle(s)
% Copyright: Ioannis Filippidis, 2012-

[~, Dbi, D2bi] = beta_heterogenous(x, obstacles);

%[~, Db, D2b] = biDbiD2bi2bDbD2b(bi, Dbi, D2bi);
Db = Dbi{1};
D2b = D2bi;

idx = isnan(Db(1, :) );

x(:, idx) = [];
Db(:, idx) = [];
D2b(:, idx) = [];

plot_implicit_focal_surfaces(ax, x, res, Db, D2b)