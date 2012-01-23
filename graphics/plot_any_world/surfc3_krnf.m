function [varargout] = surfc3_krnf(ax, domain, resolution, qd, obstacles, k)
%SURFC3_KRNF    plot KRNF surface over 2D domain
%
% usage
%   H = SURFC3_KRNF(DOMAIN, RESOLUTION, QD, OBSTACLES, K)
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
% See also QUIVER_KRNF, DOMAIN2KRNF, KRNF2SURFC, SURFC3.
%
% File:      surfc3_krnf.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.01.22
% Language:  MATLAB R2011b
% Purpose:   plot KRNF surface over 2D rectangular domain
% Copyright: Ioannis Filippidis, 2010-

[X, Y, nfZ] = domain2krnf(domain, resolution, qd, obstacles, k);
h = krnf2surfc(ax, X, Y, nfZ, [] );

if nargout == 1
    varargout{1, 1} = h;
end
