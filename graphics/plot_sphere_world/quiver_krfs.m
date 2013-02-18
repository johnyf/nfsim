function [varargout] = quiver_krfs(ax, domain, resolution, qd, qc, r0, r, k, mask)
%QUIVER_KRFS    plot KRNFS negated gradient field over 2D rectangular domain
%
% usage
%    H = QUIVER_KRFS(AX, DOMAIN, RESOLUTION, QD, XC, R, K, MASK_OBSTACLES)
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
% 2012.01.22 (c) Ioannis Filippidis, jfilippidis@gmail.com
%
% See also SURFC3_KRFS, DOMAIN2GRAD_KRFS, QUIVERMD.

[x, grad_krfx] = domain2grad_krfs(domain, resolution, qd, qc, r0, r, k, mask);
h = quivermd(ax, x, -grad_krfx);

if nargout == 1
    varargout{1, 1} = h;
end
