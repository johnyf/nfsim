function [X, Y, Z] = domain2krfs(domain, resolution, qd, qc, r0, r, k, mask)
%DOMAIN2KRFS   calculate KRFS over 2D rectangular domain
%
% usage
%   [X, Y, Z] = domain2krfs(domain, resolution, qd, qc, r0, r, k, mask)
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
%   [X, Y, Z] KRFS surface compliant with meshgrid and surf
%
% use previously:
%   [xc, r] = convex2sphere_world(world, known_world);
%   [qc, r, r0] = xcr2qcrr0(xc, r);
%
% 2010.09.15 - 2012.01.22 (c) Ioannis Filippidis, jfilippidis@gmail.com

%% input
if nargin < 7
    mask = 1;
end

%% calculate
[X, Y] = domain2meshgrid(domain, resolution);
q = meshgrid2vec(X, Y);

f = krfs(q, qd, qc, r0, r, k);

Z = vec2meshgrid(f, X);

%% nan obstacle points ?
if mask == 1
    Z(Z >= 1) = nan;
end
