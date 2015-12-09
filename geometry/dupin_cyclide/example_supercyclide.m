function [] = example_supercyclide
%EXAMPLE_SUPERCYCLIDE  Plot a sample Supercyclide.
%
% See also PLOT_ELLIPTIC_SUPERCYCLIDE, PLOT_DUPIN_CYCLIDE_USING_INVERSION,
%          BETA_SUPERCYCLIDE, EXAMPLE_DUPIN_CYCLIDE.
%
% File:      plot_dupin_cyclide.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.05.19
% Language:  MATLAB R2012a
% Purpose:   Plot a Dupin cyclide
% Copyright: Ioannis Filippidis, 2012-

%% plot supercyclide
ax = newax;

qc = [8, 0, 0].';
R = 4;
rm = 2;
dr = 0.5;

q0 = [1, 2, 2].'; % semi-radii
rot = eye(3);

h1 = plot_elliptic_supercyclide(ax, qc, R, rm, dr, rot, q0);
cmap1 = jet(64);

%% plot function level sets and gradient over a plane
dom = [0, 16, 0, 0, -4, 4];
res = [40, 1, 40];

[q, X, Y, Z] = domain2vec(dom, res);
[bi, Dbi, ~] = beta_supercyclide(q, qc, R, rm, dr, rot, q0);
Bi = vec2meshgrid(bi, X);

Xs = squeeze(X);
Ys = squeeze(Y);
Zs = squeeze(Z);
Bis = squeeze(Bi);

Bis(700 < Bis) = nan;

hold(ax, 'on')
h2 = surf(ax, Xs, Ys, Zs, Bis);
cmap2 = bluewhitered(h2, 32, 'CData');
set(h2, 'EdgeColor', 'none')

assign_cmaps(ax, h1, h2, cmap1, cmap2, 'ZData', 'CData')

quivermd(ax, q, normvec(Dbi), 0.4)
axis(ax, 'tight')
axis(ax, 'off')
axis(ax, 'equal')
