function [varargout] = surfc3_krnfs(ax, domain, resolution, qd, qc, r0, r, k, mask)
%SURFC3_KRNFS    plot KRNFS surface over 2D domain
%
% usage
%   H = SURFC3_KRNFS(DOMAIN, RESOLUTION, QD, QC, R0, R, K, MASK)
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
% See also QUIVER_KRNFS, DOMAIN2KRNFS, KRNF2SURFC3, SURFC3.
%
% File:      surfc3_krnfs.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.01.22 - 
% Language:  MATLAB R2011b
% Purpose:   plot KRNFS surface over 2D rectangular domain
% Copyright: Ioannis Filippidis, 2010-

[X, Y, nfZ] = domain2krnfs(domain, resolution, qd, qc, r0, r, k, mask);
h = krnf2surfc(ax, X, Y, nfZ, [] );

if nargout == 1
    varargout{1, 1} = h;
end
