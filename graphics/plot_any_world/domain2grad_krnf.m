function [q, grad_krnfq, X, Y, Gx, Gy] = domain2grad_krnf(domain,...
                                            resolution, qd, obstacles, k)
%DOMAIN2GRAD_KRNF   KRNF gradient over 2D domain
%
% usage
%   [q, grad_krnfq, X, Y, gx, gy] = ...
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
%     = [ny x nx]
%   Y = meshgrid point ordinates
%     = [ny x nx]
%   Gx = gradient x components
%      = [ny x nx]
%   Gy = gradient y components
%      = [ny x nx]
%
% See also DOMAIN2KRNF, GRAD_KRNF.
%
% File:      domain2grad_krnf.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.01.22 - 2012.01.27
% Language:  MATLAB R2011b
% Purpose:   calculate NF gradient field over rectangular domain
% Copyright: Ioannis Filippidis, 2012-

[q, X, Y] = domain2vec(domain, resolution);

[bi, Dbi] = beta_heterogenous(q, obstacles);
[b, Db] = biDbiD2bi2bDbD2b(bi, Dbi);

[gd, Dgd] = gamma_d(q, qd);
grad_krnfq = grad_krnf(gd, Dgd, b, Db, k);

if nargout >= 5
    [Gx, Gy] = vec2meshgrid(grad_krnfq, X);
end
