function [] = example_dupin_cyclide
%EXAMPLE_DUPIN_CYCLIDE  Plot a sample Dupin cyclide.
%
% See also PLOT_ELLIPTIC_SUPERCYCLIDE, PLOT_DUPIN_CYCLIDE_USING_INVERSION,
%          BETA_SUPERCYCLIDE, EXAMPLE_SUPERCYCLIDE.
%
% File:      plot_dupin_cyclide.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.02.19
% Language:  MATLAB R2012a
% Purpose:   Plot a Dupin cyclide
% Copyright: Ioannis Filippidis, 2012-

%% plot cyclide
qc = [8, 0, 0].';
r = 4;
q0 = zeros(3, 1);
r0 = 5;

ax = newax;
plot_dupin_cyclide_using_inversion(ax, qc, r, q0, r0)
axis(ax, 'tight')
axis(ax, 'equal')
axis(ax, 'off')
