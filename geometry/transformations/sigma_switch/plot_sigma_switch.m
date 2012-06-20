function plot_sigma_switch
%
% See also SIGMA_SWITCH.
%
% File:      plot_sigma_switch.m
% Author:    Ioannis Filippidis jfilippidis@gmail.com
% Date:      2010.09.19 - 2012.05.21
% Language:  MATLAB R2012a
% Purpose:   plot C^2 switch function S(x) and its derivatives dS(x)/dx,
%            d^2S(x)/dx^2
% Copyright: Ioannis Filippidis, 2010-

% depends
%   sigma_switch, tex_plot_annot

x = linspace(0,1);
[s, ds, d2s] = sigma_switch(x);

fig = figure;
ax1 = subplot(3, 1, 1, 'Parent', fig);
    plot(ax1, x,s)
    grid(ax1, 'on')
    tex_plot_annot(ax1,...
        'The $C^2(x)$ switch function $S(x)=-6x^5+15x^4-10x^3+1$',...
        [], '$S(x)$', [], [] )

ax2 = subplot(3, 1, 2, 'Parent', fig);
    plot(ax2, x, ds)
    grid(ax2, 'on')
    tex_plot_annot(ax2, [], [], '$\frac{dS(x)}{dx}$', [], [] )
    
ax3 = subplot(3, 1, 3, 'Parent', fig);
    plot(ax3, x, d2s)
    grid(ax3, 'on')
    tex_plot_annot(ax3, [], '$x$', '$\frac{d^2S(x)}{dx^2}$', [], [] )
