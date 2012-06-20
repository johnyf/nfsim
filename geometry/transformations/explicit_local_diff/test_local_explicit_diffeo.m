function [] = test_local_explicit_diffeo
%TEST_LOCAL_EXPLICIT_DIFFEO     Testing local explicit diffeomorphism.
%
% See also LOCAL_EXPLICIT_DIFFEO, PLOT_MAPPING, PARAMETRIC_LEMNISCATE_BOOTH.
%
% File:      test_local_explicit_diffeo.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.05.21
% Language:  MATLAB R2012a
% Purpose:   plot example diffeomorphism from local explicit diffeomorphism
%            from lemniscate to sphere (in polar coordinates)
% Copyright: Ioannis Filippidis, 2012-

% depends
%   domain2vec, parametric_lemniscate_booth, plot_lemniscate_booth
%   plot_sphere, beta_lemniscate_booth, bi2b,
%   global_cart2local_pol, local_explicit_diffeo, plot_mapping

%% grid of points
domain = [-12, 12, -7, 7];
res = [70, 50];

[q, X, ~, Z] = domain2vec(domain, res);

%% init real ellipse world
qc = [0, 0].';
rot = {eye(2) };
%{
r = {[2, 3] };

ellipses = create_quadrics(xc, rot, r);

obstacles = create_heterogenous_obstacles(ellipses, [],...
                                            [], [], [] );
%}

%% select effect zone
[theta, r] = global_cart2local_pol(q, qc);

a = 0.8;
r0 = 5;
r0_out = 10;

r_in = parametric_lemniscate_booth(theta, a, r0);
r_out = parametric_lemniscate_booth(theta, a, r0_out);

%% init model sphere world
qc_model = [0, 0].';
rho = 1;

%% graphics
fig = figure;
ax1 = subplot(2, 1, 1, 'Parent', fig);
    %axis(ax1, 'off')
    hold(ax1, 'on')
ax2 = subplot(2, 1, 2, 'Parent', fig);
    %axis(ax2, 'off')
    hold(ax2, 'on')

npnt = 35;
%    plot_heterogenous_obstacles(ax1, obstacles, npnt)
    plot_lemniscate_booth(ax1, a, r0)
    plot_lemniscate_booth(ax1, a, r0_out)
    
    plot_sphere(ax2, qc_model, rho)

%% map
% clear points within obstacle
%bi = beta_heterogenous(q, obstacles);
bi = beta_lemniscate_booth(q, qc, a, r0);
b = bi2b(bi);
theta(:, b <= 0) = nan;
%{
qmodel = vpol2cart(theta, r);
plot(ax2, r_in.*cos(theta), r_in.*sin(theta), 'o')
plot(ax2, r_out.*cos(theta), r_out.*sin(theta), '*')
%}
qmodel = local_explicit_diffeo(theta, r, r_in, r_out, qc_model, rho);

%% plot
plot_mapping([ax1, ax2], q, qmodel, X, Z)
