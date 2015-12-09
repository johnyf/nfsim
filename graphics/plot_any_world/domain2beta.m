function [q, b, Db, varargout] = domain2beta(domain, resolution, obstacles)
%DOMAIN2BETA    obstacle function, derivatives in 2/3D rectangular domain
%
% usage
%  2D: [q, b, Db, X, Y, B, Dbx, Dby] = ...
%           DOMAIN2BETA(domain, resolution, obstacles)
%  3D: [q, b, Db, X, Y, Z, B, Dbx, Dby, Dbz] = ...
%           DOMAIN2BETA(domain, resolution, obstacles)
%  ND: [q, b, Db] = DOMAIN2BETA(domain, resolution, obstacles)
%
% input
%   domain = [xmin, xmax, ymin, ymax]
%   resolution = [nx, ny]
%   obstacles = obstacle structure array as returned by
%               CREATE_HETEROGENOUS_OBSTACLES
%
% output
%   q = matrix of column vectors of meshgrid point coordinates
%     = [#dim x #points]
%   b = obstacle function values on meshgrid points q
%     = [1 x #points]
%   Db = obstacle function gradient on meshgrid points q
%      = [#ndim x #points]
%   X = matrix of meshgrid point abscissas (nz = 1 for the 2D case)
%     = [ny x nx x nz]
%   Y = matrix of meshgrid point ordinates (nz = 1 for the 2D case)
%     = [ny x nx x nz]
%   Z = matrix of meshgrid point coordinates (Z defined only for 3D case)
%     = [ny x nx x nz]
%   B = obstacle function values on meshgrid points q
%     = [ny x nx x nz]
%   Dbx = obstacle function gradient x components on meshgrid points q
%       = [ny x nx x nz]
%   Dby = obstacle function gradient y components on meshgrid points q
%       = [ny x nx x nz]
%   Dbz = obstacle function gradient z components on meshgrid points q
%       = [ny x nx x nz]
%
% 2012.01.24 (c) Ioannis Filippidis, jfilippidis@gmail.com
%
% See also DOMAIN2KRF, BETA_HETEROGENOUS.

ndim = size(domain, 2) /2;

if ndim == 2
    [q, X, Y] = domain2vec(domain, resolution);
elseif ndim == 3
    [q, X, Y, Z] = domain2vec(domain, resolution);
else
    % no plots in higher dimensions
    q = domain2vec(domain, resolution);
end

[bi, Dbi] = beta_heterogenous(q, obstacles);
[b, Db] = biDbiD2bi2bDbD2b(bi, Dbi);

%% output
if nargout > 3
    varargout{1, 1} = X;
    varargout{1, 2} = Y;
    
    if ndim == 2
        B = scalar2meshgrid(b, X);
        [Dbx, Dby] = vec2meshgrid(Db, X);
        
        varargout{1, 3} = B;
        varargout{1, 4} = Dbx;
        varargout{1, 5} = Dby;
    elseif ndim == 3
        varargout{1, 2} = Z;
        
        B = scalar2meshgrid(b, X);
        [Dbx, Dby, Dbz] = vec2meshgrid(Db, X);
        
        varargout{1, 3} = B;
        varargout{1, 4} = Dbx;
        varargout{1, 5} = Dby;
        varargout{1, 5} = Dbz;
    else
        error('For N-dimensional spaces, only q, b, Db returned.')
    end
end
