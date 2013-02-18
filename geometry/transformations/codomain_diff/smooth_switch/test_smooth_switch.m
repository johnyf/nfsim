function [] = test_smooth_switch
%TEST_SMOOTH_SWITCH     Testing the smooth switch function.
%
% See also smooth_switch, smooth_switch_normalized, inf_length_switch.
%
% File:      test_smooth_switch.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.09.13
% Language:  MATLAB R2012a
% Copyright: Ioannis Filippidis, 2012-

close all
npnt = 1000;

%% inf length switch
t = linspace(-10, 10, npnt);

[s, ds, d2s] = inf_length_switch(t);

ax = newax(figure, [3, 1] );

plot(ax(1), t, s)
title(ax(1), 'Inf Switch')
plot(ax(2), t, ds)
plot(ax(3), t, d2s)

%% normalized smooth switch
u = linspace(-1, 2, npnt);

[s, ds, d2s] = smooth_switch_normalized(u);

ax = newax(figure, [3, 1] );

plot(ax(1), u, s)
title(ax(1), 'Normalized Smooth Switch')
plot(ax(2), u, ds)
plot(ax(3), u, d2s)

%% smooth switch
xmin = 0.4;
xmax = 2.1;

x = linspace(xmin, xmax, npnt).';

x1 = 0.5;
e = 1.5;

[f, df, d2f] = smooth_switch(x, x1, e);

ax = newax(figure, [3, 1] );

plot(ax(1), x, f)
plot_scalings(ax(1), 0)
tex_plot_annot(ax(1), 'Smooth switch', [], '$\sigma_{\delta, x_0}(x)$')

plot(ax(2), x, df)
plot_scalings(ax(2), 0)
tex_plot_annot(ax(2), [], [], '$\frac{d\sigma_{\delta, x_0} }{dx}(x)$')

plot(ax(3), x, d2f)
plot_scalings(ax(3), 0)
tex_plot_annot(ax(3), [], '$x$', '$\frac{d\sigma_{\delta, x_0} }{dx}(x)$')
