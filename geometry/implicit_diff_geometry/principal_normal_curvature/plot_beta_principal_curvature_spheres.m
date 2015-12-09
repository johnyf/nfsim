function [] = plot_beta_principal_curvature_spheres(ax, x, obstacles)
%PLOT_BETA_PRINCIPAL_CURVATURE_SPHERES  Plot obstacle principal curvature
%   spheres.
%
% usage
%   PLOT_BETA_PRINCIPAL_CURVATURE_SPHERES(ax, x, obstacles)
%
% input
%   ax = axes object handle
%   x = implicit surface points
%     = [#dim x #pnts]
%   obstacles = struct array of obstacles, see
%               create_heterogenous_obstacles
%
% reference
%   Filippidis, I.; Kyriakopoulos K.J.
%   Navigation Functions for Everywhere Partially Sufficiently Curved
%   Worlds
%   IEEE International Conference on Robotics and Automation,
%   St. Paul, Minnesota, USA, 2012 (ICRA'12)
%
% See also PLOT_BETA_PRINCIPAL_CURVATURE_CIRCLES,
%          PLOT_IMPLICIT_PRINCIPAL_CURVATURE_SPHERES.
%
% File:      plot_beta_principal_curvature_spheres.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.01.29
% Language:  MATLAB R2012a
% Purpose:   
% Copyright: Ioannis Filippidis, 2012-

[bi, Dbi, D2bi] = beta_heterogenous(x, obstacles);
[~, Db, D2b] = biDbiD2bi2bDbD2b(bi, Dbi, D2bi);

idx = isnan(Db(1, :) );

x(:, idx) = [];
Db(:, idx) = [];
D2b(:, idx) = [];

plot_implicit_principal_curvature_spheres(ax, x, Db, D2b)
