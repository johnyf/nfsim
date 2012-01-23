function [x, grad_krnfx] = domain2grad_krnf(domain, resolution, qd, obstacles, k)
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
%   [x, grad_krnfx] = domain2grad_krnf(domain, resolution, qd, obstacles, k)
%
% File:      domain2grad_krnf.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.01.22 - 
% Language:  MATLAB R2011b
% Purpose:   calculate NF gradient field over rectangular domain
% Copyright: Ioannis Filippidis, 2012-

res = resolution;
[X, Y] = domain2meshgrid(domain, res);
x = meshgrid2vec(X, Y);

[bi, Dbi] = beta_heterogenous(x, obstacles);
[b, Db] = biDbiD2bi2bDbD2b(bi, Dbi);

[gd, Dgd] = gamma_d(x, qd);
grad_krnfx = grad_krnf(gd, Dgd, b, Db, k);
