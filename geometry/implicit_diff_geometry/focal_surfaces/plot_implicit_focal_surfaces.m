function [] = plot_implicit_focal_surfaces(ax, x, res, grad, Hessian)
%PLOT_IMPLICIT_FOCAL_SURFACES   Plot obstacle focal surface sheets.
%
% usage
%   PLOT_IMPLICIT_FOCAL_SURFACES(ax, x, res, grad, Hessian)
%
% input
%   ax = axes object handle
%   x = implicit surface points
%     = [#dim x #pnts]
%   res = resolution of points on surface, in parametric domain
%       = [#pnts_u, #pnts_v]
%   grad = implicit function gradient at x
%        = [#dim x #pnts]
%   Hessian = Hessian matrices of implicit function at x
%           = {1 x #pnts} = {[#dim x #dim], ... }
%
% See also PLOT_BETA_FOCAL_SURFACES, PLOT_IMPLICIT_FOCAL_SURFACE.
%
% File:      plot_implicit_focal_surfaces.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.02.19
% Language:  MATLAB R2012a
% Purpose:   plot focal surface sheets of implicitly defined surface
% Copyright: Ioannis Filippidis, 2012-

ndim = size(x, 1);
n = ndim -1;
for focal_no=1:n
    plot_implicit_focal_surface(ax, x, res, grad, Hessian, focal_no, 'sorted');
end
