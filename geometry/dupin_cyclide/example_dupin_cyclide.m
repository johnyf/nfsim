function [] = example_dupin_cyclide
%EXAMPLE_DUPIN_CYCLIDE  plot a sample Dupin cyclide.
%
% See also PLOT_DUPIN_CYCLIDE.

qc = [8, 0, 0].';
r = 4;
q0 = zeros(3, 1);
r0 = 5;

ax = newax;
plot_dupin_cyclide(ax, qc, r, q0, r0)
axis(ax, 'image')
axis(ax, 'off')
