% File:      plot_poly_P.m
% Author:    Ioannis Filippidis, Mechanical Engineer, jfilippidis@gmail.com
% Date:      2010.09.30
% Language:  MATLAB, program version: 7.11 (2010b)
% Purpose:   plot polynomial P(x) in [0,1]
% Copyright: Ioannis Filippidis, 2010-

function [] = plot_poly_P
x = linspace(0,1,100);
y = P(x);

figure;
    plot(x, y, 'b-')
    grid on

    title('Polynomial function P(x) for b_i(z_i) = P(z_i) when z_i\in[0,1]')
    xlabel('x')
    ylabel('P(x)')
