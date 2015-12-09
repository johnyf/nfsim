function [] = test_khatib(ax)
% File:      test_khatib.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.08.03 - 2011.09.12
% Language:  MATLAB R2011a
% Purpose:   test Khatib potential field code
% Copyright: Ioannis Filippidis, 2011-

if ~exist('ax')
    fig = figure;
    ax = axes('Parent', fig);
end

%% calculation points
x = linspace(0, 20, 60);
y = linspace(0, 20, 60);
[X, Y] = meshgrid(x, y);
q = [X(:),  Y(:) ].';

[m, n] = size(X);

%% destination
q0 = [1, 2].';
qd = [12, 9].';

%% parameters
kp = 1;
eta = 300; % 10 for thesis, this value here causes local minimum
b0 = 10;

%% elliptical obstacles
quadrics = khatib_testing_obstacles;
[bi, ~, ~] = beta_ellipsoids(q, quadrics);

%% potential field
[gd, ~] = gamma_d(q, qd);
z = khatib(gd, bi, kp, eta, b0);
z = reshape(z, m, n);

%% integrate
maxiter = 1000;
step = 0.1;
qhist = integrate_khatib(q0, qd, quadrics, kp, eta, b0, maxiter, step);

%% plot
% avoid too large values  close to obstacle for details to be visible
z(z > 10^2) = 10^2; % aesthetically pleasing ceiling
surf(ax, x, y, z)
plot_scalings(ax, 0);
tex_plot_annot(ax, 'Khatib Potential Field', '$x$', '$y$', '$U=U_d +U_o$', []);

hold(ax, 'on')
plot(ax, qhist(1, :), qhist(2, :) )
plot(ax, qhist(1, end), qhist(2, end), 'r*')
plotmd(ax, qd, 'go')

