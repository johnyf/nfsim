function [q, grad_krnfq, varargout] = domain2grad_krnf(domain,...
                                            resolution, qd, obstacles, k)
%DOMAIN2GRAD_KRNF   KRNF gradient over 2D domain
%
% usage (2D case)
%   [q, grad_krnfq, X, Y, Gx, Gy] = ...
%                   DOMAIN2GRAD_KRNF(domain, resolution, qd, obstacles, k)
%
% usage (3D case)
%   [q, grad_krnfq, X, Y, Z, Gx, Gy, Gz] = ...
%                   DOMAIN2GRAD_KRNF(domain, resolution, qd, obstacles, k)
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
%   q = meshgrid point coordinates as matrix of column vectors
%     = [#dim x #points]
%      Note: #points = nx *ny
%   grad_krnfq = KRNF gradient as matrix of column vectors
%             = [#dim x #points]
%   X = meshgrid point abscissas
%     = [ny x nx x nz]
%   Y = meshgrid point ordinates
%     = [ny x nx x nz]
%   Z = meshgrid point coordinates
%     = [ny x nx x nz]
%   Gx = gradient x components
%      = [ny x nx x nz]
%   Gy = gradient y components
%      = [ny x nx x nz]
%   Gz = gradient z components
%      = [ny x nx x nz]
%
% See also DOMAIN2KRNF, GRAD_KRNF.
%
% File:      domain2grad_krnf.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.01.22 - 2012.01.27
% Language:  MATLAB R2011b
% Purpose:   calculate NF gradient field over rectangular domain
% Copyright: Ioannis Filippidis, 2012-

ndim = size(domain, 2) /2;

if ndim == 2
    [q, X, Y] = domain2vec(domain, resolution);
elseif ndim == 3
    [q, X, Y, Z] = domain2vec(domain, resolution);
end

[bi, Dbi] = beta_heterogenous(q, obstacles);
[b, Db] = biDbiD2bi2bDbD2b(bi, Dbi);

[gd, Dgd] = gamma_d(q, qd);
grad_krnfq = grad_krnf(gd, Dgd, b, Db, k);

if ndim == 2
    [Gx, Gy] = vec2meshgrid(grad_krnfq, X);
    varargout = {X, Y, Gx, Gy};
elseif ndim == 3
    [Gx, Gy, Gz] = vec2meshgrid(grad_krnfq, X);
    varargout = {X, Y, Z, Gx, Gy, Gz};
end
