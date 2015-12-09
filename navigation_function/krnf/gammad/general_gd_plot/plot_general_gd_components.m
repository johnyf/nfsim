function [] = plot_general_gd_components
% File:      plot_general_gd_components.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.12.21 - 2011.12.23
% Language:  MATLAB R2011b
% Purpose:   plots of Mika's \gamma_d and its component functions
% Copyright: Ioannis Filippidis, 2011-

close all

domain = [-1, 1, -1, 1];

% \gamma_d
formula = '(x.^2 +y.^2)^0.5 +5 *tanh(10 *(x.^2 +y.^2)^0.5) .*y.^2 .*(x.^2 +y.^2).^-1';
latexformula = '$r +R \tanh(\mu r) \sin^2\theta$';
fname = 'gammad';
create_ezsurf_plot(formula, domain, latexformula, fname)

% r
formula = '(x.^2 +y.^2)^0.5';
latexformula = '$r$';
fname = 'r';
create_ezsurf_plot(formula, domain, latexformula, fname)

% \tanh(\mu r) \sin^2\theta
formula = '5 *tanh(10 *(x.^2 +y.^2)^0.5) .*y.^2 .*(x.^2 +y.^2).^-1';
latexformula = '$\tanh(\mu r) \sin^2\theta$';
fname = 'tanh sin2';
create_ezsurf_plot(formula, domain, latexformula, fname)

% \tanh
formula = 'tanh((x.^2 +y.^2)^0.5)';
latexformula = '$\tanh(\mu r)$';
fname = 'tanh';
create_ezsurf_plot(formula, domain, latexformula, fname)

% \sin(\theta)
formula = 'y ./(x.^2 +y.^2).^0.5';
latexformula = '$\sin\theta$';
fname = 'sin';
create_ezsurf_plot(formula, domain, latexformula, fname)

% \sin^2(\theta)
formula = 'y.^2 ./(x.^2 +y.^2)';
latexformula = '$\sin^2\theta$';
fname = 'sin2';
create_ezsurf_plot(formula, domain, latexformula, fname)

% r \sin^2(\theta)
formula = 'y.^2 ./(x.^2 +y.^2)^0.5';
latexformula = '$r \sin^2\theta$';
fname = 'rsin2';
create_ezsurf_plot(formula, domain, latexformula, fname)

function [] = create_ezsurf_plot(formula, domain, latexformula, fname)
fig = figure;
ax = axes('Parent', fig);
hold(ax, 'on')
ezsurf(ax, formula, domain)
ezcontour(ax, formula, domain)

title('')
tex_plot_annot(ax, [], '$x$', '$y$', latexformula, [] )
grid(ax, 'on')
view(ax, 3)
axis(ax, 'equal')

plot_scalings(gca, 0)
maximize
%export_fig('-pdf', '-painters', [fname, '.pdf'] )
