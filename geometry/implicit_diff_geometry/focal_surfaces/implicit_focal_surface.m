function [qk, res] = implicit_focal_surface(q, res, grad, Hessian, focal_no)
%IMPLICIT_FOCAL_SURFACE     Focal surface sheet points of implicit surface.
%
% usage
%   [qk, res] = IMPLICIT_FOCAL_SURFACE(q, res, grad, Hessian, focal_no)
%
% input
%   q = implicit surface points
%     = [#dim x #pnts]
%   res = resolution of points on surface, in parametric domain
%       = [#pnts_u x #pnts]
%   grad = implicit function gradient at q
%        = [#dim x #pnts]
%   Hessian = Hessian matrices of implicit function at q
%           = {1 x #pnts} = {[#dim x #dim], ... }
%   focal_no = number of selected focal surface (ordering by principal
%              curvatures)
%
% output
%   qk = points comprising the selected focal surface sheet
%      = [#dim x #pnts]
%   res = numbers of points per dimension of the parametric domain
%       = [#pnts_u, #pnts_v]
%
% See also PLOT_IMPLICIT_FOCAL_SURFACE,
%          IMPLICIT_PRINCIPAL_CURVATURE_SPHERES.
%
% File:      implicit_focal_surface.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.02.19
% Language:  MATLAB R2012a
% Purpose:   calculate focal surface sheet of implicit surface
% Copyright: Ioannis Filippidis, 2012-

% focal = evolvent +normals
[qc, R] = implicit_principal_curvature_spheres(q, grad, Hessian);

% surface neighbor connectivity info
m = size(qc, 2);
ndim = size(q, 1);
qk = nan(ndim, m);
Rk = nan(1, m);
for i=1:m
    qk(:, i) = qc{1, i}(:, focal_no);
    Rk(1, i) = R(focal_no, i);
end

qk = bsxfun(@times, abs(Rk), normvec(qk -q) ) +q;
