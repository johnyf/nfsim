function [varargout] = quiver_krnfs(ax, domain, resolution, qd, qc, r0, r, k, mask)
%QUIVER_KRNFS    plot KRNFS negated gradient field over 2D domain
%
% usage
%    H = QUIVER_KRNFS(AX, DOMAIN, RESOLUTION, QD, XC, R, K, MASK_OBSTACLES)
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
% See also SURFC3_KRNFS, DOMAIN2GRAD_KRNFS, QUIVERMD.
%
% File:      quiver_krnfs.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.01.22 - 
% Language:  MATLAB R2011b
% Purpose:   plot KRNFS negated gradient field over 2D rectangular domain
% Copyright: Ioannis Filippidis, 2012-

[x, grad_krnfx] = domain2grad_krnfs(domain, resolution, qd, qc, r0, r, k, mask);
h = quivermd(ax, x, -grad_krnfx);

if nargout == 1
    varargout{1, 1} = h;
end
