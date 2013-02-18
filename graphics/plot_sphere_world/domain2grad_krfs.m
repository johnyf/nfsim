function [x, grad_krfsx] = domain2grad_krfs(domain, resolution, qd, qc, r0, r, k, mask)
%DOMAIN2GRAD_KRFS    calculate KRFS gradient field over 2D rectangular domain
%
% usage
%    [X, GRAD_KRFSX] = DOMAIN2GRAD_KRFS(DOMAIN, RESOLUTION, QD, XC, R, K, MASK)
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
% 2012.01.22 -  (c) Ioannis Filippidis, jfilippidis@gmail.com
%
% See also QUIVER_KRFS.

%todo
%   implement masking of points within obstacles

[X, Y] = domain2meshgrid(domain, resolution);
x = meshgrid2vec(X, Y);

grad_krfsx = normalized_grad_krfs(x, qd, qc, r0, r, k);
