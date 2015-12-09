function [X, Y, krfZ] = domain2krf(domain, resolution, qd, obstacles, k)
%DOMAIN2KRF    Compute Kodistchek-Rimon  in rectangular domain
%
% usage
%   [X, Y, Z] = DOMAIN2KRF(domain, resolution, qd, obstacles, k)
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
%   X = meshgrid point abscissas
%     = [ny x nx]
%   Y = meshgrid point ordinates
%     = [ny x nx]
%   krfZ = KRF values at meshgrid points
%         = [ny x nx]
%
% 2010.09.16 - 2012.01.22 (c) Ioannis Filippidis, jfilippidis@gmail.com
%
% See also DOMAIN2GRAD_KRF, SURFC3_KRF, KRF2SURFC3, krf.

[q, X, Y] = domain2vec(domain, resolution);

bi = beta_heterogenous(q, obstacles);
b = biDbiD2bi2bDbD2b(bi);

gd = gamma_d(q, qd);
f = krf(gd, b, k);

krfZ = scalar2meshgrid(f, X);
    