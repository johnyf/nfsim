function plot_T1(rho, r_in, r_out)
%
% See also TI, JTI, PLOT_BI.
%
% File:         plot_T1.m
% Programmer:   Ioannis Filippidis, jfilippidis@gmail.com
% Date:         2010.09.18 - 2012.05.21
% Language:     MATLAB R2010b
% Purpose:      plot radius transformation function T1
% Copyright:    Ioannis Filippidis, 2010-

% depends
%   Ti, JTi, tex_plot_annot

theta = 0;

%% Radius transformation function T^1(r,\theta) vs r
ax = newax;
    r1 = linspace(r_in, r_out);

    r1_new = zeros( size(r1) );
    r1_dif = zeros( size(r1) );
    for i=1:length(r1)
        a = Ti(theta, r1(i), r_in, r_out, rho);
        r1_new(i) = a(1, 1);
        f = JTi(theta, r1(i), r_in, r_out, rho);
        r1_dif(i) = f(1,1);
    end

    plot(ax, r1 ./r_in, r1_new ./rho, 'b-')
    hold(ax, 'on')
    plot(ax, [r_in, r_out] ./r_in, [r_out, r_out] ./rho, 'r--') % y = r_{out} /\rho_i
    plot(ax, [r_out, r_out] ./r_in, [rho, r_out] ./rho, 'r--') % x = r_{out} /r_in

    plot(ax, [r_in, r_out] ./r_in, [rho, r_out] ./rho, 'm--') % ri /\rho_i = r/r_in line
    plot(ax, [r_out, 1.1*r_out] ./r_in, [r_out, 1.1*r_out] ./rho, 'b-') % part of identity map
    grid(ax, 'on')
    plot_scalings(ax, 0)

    tex_plot_annot(ax,...
        '$\frac{r_i(r)}{\rho_i}$ Radius map',...
        '$\frac{r}{r_{in}}$ (-)',...
        '$\frac{r_i(r)}{\rho_i}$ (-)',...
        [],...
        {'$\frac{r_i(r)}{\rho_i} = \frac{T^1(r,\theta)}{\rho_i}$', '$\frac{r_{out}}{\rho_i}$'} )
    %export_fig('-pdf', '-painters', 'radius_map')

%% Radius transformation function derivative T^1_r(r,\theta) vs r
ax = newax;
    plot(ax, r1 ./r_in, r1_dif, 'b')
    hold(ax, 'on')
    plot(ax, [r_out, r_out] ./r_in, [0, max(r1_dif)], 'r--') % x = r_{out} /r_in
    plot(ax, [r_out, 1.1*r_out] ./r_in, [1, 1], 'b-') % identity map
    grid(ax, 'on')
    plot_scalings(ax, 0)

    tex_plot_annot(ax,...
        '$\frac{\partial r_i(r)}{\partial r}$ Radius map derivative',...
        '$\frac{r}{r_{in}}$ (-)',...
        '$\frac{\partial\rho(r)}{\partial r}$ ($\frac{1}{L}$)',...
        [], [] )
    %export_fig('-pdf', '-painters', 'radius_map_derivative')
