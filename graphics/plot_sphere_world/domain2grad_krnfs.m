function [x, grad_krnfsx] = domain2grad_krnfs(domain, resolution, qd, qc, r0, r, k, mask)
%DOMAIN2GRAD_KRNFS    calculate KRNFS gradient field over 2D domain
%
% usage
%    [X, GRAD_KRNFSX] = DOMAIN2GRAD_KRNFS(DOMAIN, RESOLUTION, QD, XC, R, K, MASK)
%
% input
%   domain = [xmin, xmax, ymin, ymax]
%   resolution = [nx, ny]
%   qd = destination
%      = [#dim x 1]
%   qc = internal sphere centers
%      = [#dim x #spheres]
%   r0 = 0th obstacle radius
%      > 0
%   r = internal sphere radii
%     = [1 x #spheres]
%   k = tuning parameter
%   mask = 1 | 0, to mask or not, respectively, the obstacle points
%
% output
%   h = handle to quiver object
%
% See also QUIVER_KRNFS.
%
% File:      domain2grad_krnfs.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.01.22 - 
% Language:  MATLAB R2011b
% Purpose:   calculate KRNFS gradient field over 2D rectangular domain
% Copyright: Ioannis Filippidis, 2012-

%todo: implement masking of points within obstacles

[X, Y] = domain2meshgrid(domain, resolution);
x = meshgrid2vec(X, Y);

grad_krnfsx = normalized_grad_krnfs(x, qd, qc, r0, r, k);
