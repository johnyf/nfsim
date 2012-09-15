function [xfocal] = plot_implicit_focal_surface(ax, x, res, grad, Hessian, focal_no, sorted)
%PLOT_IMPLICIT_FOCAL_SURFACE    Plot focal surface of implicit surface.
%
% usage
%   PLOT_IMPLICIT_FOCAL_SURFACE(ax, x, res, grad, Hessian, focal_no)
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
%   focal_no = number of selected focal surface (ordering by principal
%              curvatures)
%
% output
%   x = points on the focal surface
%       [#dim x #pnts]
%
% See also PLOT_BETA_FOCAL_SURFACE, PLOT_IMPLICIT_FOCAL_SURFACES,
%          IMPLICIT_FOCAL_SURFACE.
%
% File:      plot_implicit_focal_surface.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.02.19
% Language:  MATLAB R2012a
% Purpose:   plot focal surface sheet of implicit surface
% Copyright: Ioannis Filippidis, 2012-

if nargin < 7
    sorted = 'sorted';
end

xfocal = implicit_focal_surface(x, grad, Hessian, focal_no, sorted);
vsurf(ax, xfocal, 'scaled', res)
%plot3(ax, X(:).', Y(:).', Z(:).', 'o')
