function [varargout] = surfc3_krfs(ax, domain, resolution, qd, qc, r0, r, k, mask)
%SURFC3_KRFS    Plot KRFS surface over 2D rectangular domain
%
% usage
%   H = SURFC3_KRFS(DOMAIN, RESOLUTION, QD, QC, R0, R, K, MASK)
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
% 2012.01.22 - (c) Ioannis Filippidis, jfilippidis@gmail.com
%
% See also QUIVER_KRFS, DOMAIN2KRFS, KRF2SURFC3, SURFC3.

[X, Y, nfZ] = domain2krfs(domain, resolution, qd, qc, r0, r, k, mask);
h = krnf2surfc(ax, X, Y, nfZ, [] );

if nargout == 1
    varargout{1, 1} = h;
end
