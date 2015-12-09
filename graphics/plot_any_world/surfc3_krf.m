function [varargout] = surfc3_krf(ax, domain, resolution, qd, obstacles, k)
%SURFC3_KRF    plot KRNF surface over 2D rectangular domain
%
% usage
%   H = SURFC3_KRF(domain, resolution, qd, obstacles, k)
%
% input
%   domain = [xmin, xmax, ymin, ymax]
%   resolution = [nx, ny]
%   qd = destination
%      = [#dim x 1]
%   obstacles = obstacle structure array as returned by
%               CREATE_HETEROGENOUS_OBSTACLES
%   k = tuning parameter
%
% output
%   h = handle to quiver object
%
% 2012.01.22 (c) Ioannis Filippidis, jfilippidis@gmail.com
%
% See also QUIVER_KRF, DOMAIN2KRF, KRF2SURFC3, SURFC3.

[X, Y, nfZ] = domain2krf(domain, resolution, qd, obstacles, k);
h = krf2surfc3(ax, X, Y, nfZ, [] );

if nargout == 1
    varargout{1, 1} = h;
end
