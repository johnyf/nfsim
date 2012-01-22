% File:      plot_nf_and_contour.m
% Author:    Ioannis Filippidis, Mechanical Engineer, jfilippidis@gmail.com
% Date:      2010.09.30
% Language:  MATLAB, program version: 7.11 (2010b)
% Purpose:   plot navigation function field in any world
% Copyright: Ioannis Filippidis, 2010-

function [] = plot_nf_and_contour(agent, world, known_world, type)
limits = [0, 6, 0, 11];
n = [48, 88];

[X, Y, nf_field, fig] = plot_nf(limits, n,...
agent, world, known_world, type);

figure;
% for actual world replace this with semi-analytic gradient, if
% possible for the given type of navigation function (dependding on the
% diffeomorphism, maybe only numerical gradient may be calculable.
% In that case finding a numerical gradient with the appropriate
% function and using the gradient function of MATLAB is essentially the
% same
[px,py] = gradient(nf_field);
contour(nf_field);
hold on
quiver(-px,-py, 2);
hold off

axis equal
