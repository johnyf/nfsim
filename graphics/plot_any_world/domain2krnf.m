function [X, Y, Z] = domain2krnf(domain, resolution, qd, obstacles, k)
% input
%   domain = [xmin, xmax, ymin, ymax]
%   resolution = [nx, ny]
%   qd = destination
%      = [#dim x 1]
%   obstacles = obstacle structure array as returned by
%               CREATE_HETEROGENOUS_OBSTACLES
%   k = tuning parameter
%
% usage
%   [X, Y, Z] = domain2krnf(domain, resolution, qd, obstacles, k)
%
% File:      domain2krnf.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2010.09.16 - 2012.01.22
% Language:  MATLAB R2010b
% Purpose:   calculate navigation function field in rectangular domain
% Copyright: Ioannis Filippidis, 2010-

res = resolution;
[X, Y] = domain2meshgrid(domain, res);
q = meshgrid2vec(X, Y);

bi = beta_heterogenous(q, obstacles);
b = biDbiD2bi2bDbD2b(bi);

gd = gamma_d(q, qd);
f = krnf(gd, b, k);

Z = vec2meshgrid(f, X);
    