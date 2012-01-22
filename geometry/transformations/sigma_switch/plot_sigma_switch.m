function plot_S
% File:      plot_S.m
% Author:    Ioannis Filippidis, Mechanical Engineer, jfilippidis@gmail.com
% Date:      2010.09.19
% Language:  MATLAB, program version: 7.11 (2010b)
% Purpose:   plot C^2 switch function S(x) and its derivatives dS(x)/dx,
%            d^2S(x)/dx^2
% Copyright: Ioannis Filippidis, 2010-

x = linspace(0,1);
s = S(x);
ds = dS(x);
d2s = d2S(x);

figure
subplot(3,1,1)
plot(x,s)
grid on

tex_plot_annot(gca,...
        'The $C^2(x)$ switch function $S(x)=-6x^5+15x^4-10x^3+1$',...
        [], '$S(x)$', [], [] )

subplot(3,1,2)
plot(x,ds)
grid on

tex_plot_annot(gca, [], [], '$\frac{dS(x)}{dx}$', [], [] )

subplot(3,1,3)
plot(x,d2s)
grid on

tex_plot_annot(gca, [], '$x$', '$\frac{d^2S(x)}{dx^2}$', [], [] )
