% File:      plot_sigma.m
% Author:    Ioannis Filippidis, Mechanical Engineer, jfilippidis@gmail.com
% Date:      2010.09.20
% Language:  MATLAB, program version: 7.11 (2010b)
% Purpose:   plot squashing diffeomorphism s(x) = x / (1+x)
% Copyright: Ioannis Filippidis, 2010-

function plot_sigma
x = linspace(0,100);
y = x ./ (x+1);

plot(x,y,'b-')
grid on
tex_plot_annot(gca,...
            'Squashing diffeomorphism $\sigma(x)=\frac{x}{x+1}$',...
            '$x$',...
            '$\sigma(x)$',...
            [])
