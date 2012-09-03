function [X, Y, Z] = domain2b_normal_curvature(domain, resolution, obstacles)
%DOMAIN2B_NORMAL_CURVATURE  Plot curvature radius for 1D level sets.
%   Plot the distribution of radius of normal curvature
%   for 1-D level sets embedded in 2-D configuration space
%
%   Note that for (N-1)-D level sets embedded in N-D C-space, vec2meshgrid
%   is needed and multiple plots will result.
%   Here a function that plots a scalar function as colors on a surface
%   (e.g. on a sphere, like the function in fex) will come handy
%
% usage
%   [X, Y, Z] = DOMAIN2B_NORMAL_CURVATURE(domain, resolution, obstacles)
%
% input
%   domain = 2-dimensional domain over which to plot
%          = [xmin, xmax, ymin, ymax]
%   resolution = # points /dimension
%              = [nx, ny]
%   obstacles = struct array of obstacles, see
%               create_heterogenous_obstacles
%
% output
%   X = meshgrid abscissa matrix
%     = [ny x nx]
%   Y = meshgrid ordinate matrix
%     = [ny x nx]
%   Z = radius of normal curvature at (X, Y)
%     = [ny x nx]
%
% See also implicit_principal_normal_curvatures,
%          create_heterogenous_obstacles.
%
% File:      domain2b_normal_curvature.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.01.24
% Language:  MATLAB R2012a
% Purpose:   surf normal curvature of 1D level sets of an implicit
%            function over its 2D domain
% Copyright: Ioannis Filippidis, 2012-

% depends
%   beta_heterogenous, biDbiD2bi2bDbD2b, implicit_principal_normal_curvatures
%   domain2vec, scalar2meshgrid

% todo: function that colors an obstacle surface according to curvature

[q, X, Y] = domain2vec(domain, resolution);

[bi, Dbi, D2bi] = beta_heterogenous(q, obstacles);
[~, Db, D2b] = biDbiD2bi2bDbD2b(bi, Dbi, D2bi);

idx = isnan(Db(1, :) );
Db(:, idx) = 0;

f = implicit_principal_normal_curvatures(Db, D2b);

Z = scalar2meshgrid(f, X);
