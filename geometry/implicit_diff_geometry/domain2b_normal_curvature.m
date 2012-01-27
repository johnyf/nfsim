function [X, Y, Z] = domain2b_normal_curvature(domain, resolution, obstacles)
% program to plot the distribution of radius of normal curvature
% for 1-D level sets embedded in 2-D configuration space
%
% Note that for (N-1)-D level sets embedded in N-D C-space, vec2meshgrid
% is needed and multiple plots will result.
% Here a function that plots a scalar function as colors on a surface
% (e.g. on a sphere, like the function in fex) will come handy
%
% File:      plot_implicit_curvature_spheres.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.01.24
% Language:  MATLAB R2011b
% Purpose:   surf normal curvature of 1D level sets of an implicit
%            function over its 2D domain
% Copyright: Ioannis Filippidis, 2012-

% todo: function that colors an obstacle surface according to curvature

[q, X, Y] = domain2vec(domain, resolution);

[bi, Dbi, D2bi] = beta_heterogenous(q, obstacles);
[~, Db, D2b] = biDbiD2bi2bDbD2b(bi, Dbi, D2bi);

idx = isnan(Db(1, :) );
Db(:, idx) = 0;

f = implicit_principal_normal_curvatures(Db, D2b);

Z = scalar2meshgrid(f, X);
