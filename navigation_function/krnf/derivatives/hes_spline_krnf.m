function [H] = hes_spline_krnf(q, qd, bsp, Dbpp, D2bpp, k)
%HES_SPLINE_KRNF    Hessian matrix of KRNF with spline obstacle
%
% inputs
%   q = current configuration
%     = [#dim x #points]
%   qd = desired destination
%      = [#dim x 1]
%   bsp = obstacle function
%           B-spline structure
%           (B form, see Curve Fitting Toolbox)
%   Dbpp = obstacle function gradient
%           Spline structure
%           (PP form, see Curve Fitting Toolbox)
%   D2bpp = obstacle function Hessian matrix
%           Spline structure
%           (PP form, see Curve Fitting Toolbox)
%   k = NF tuning parameter
%     >= 2
%
% outputs
%   H = KRNF Hessian at points q
%     = {1 x #points}
%     = {[#dimensions x #dimensions], ..., }
%
% See also SPLINE_KRNF, GRAD_SPLINE_KRNFU.
%
% File:      hes_spline_krnf.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.12.29
% Language:  MATLAB R2011b
% Purpose:   Koditschek-Rimon Navigation Function Analytical Hessian matrix
%            in the case of spline obstacle
% Copyright: Ioannis Filippidis, 2011-

b = fnval(bsp, q);
Db = fnval(Dbpp, q);
D2b = fnval(D2bpp, q);
[ndim, npnts] = size(q);
if npnts > 1
    D2b = mat2cell(D2b, ndim, ndim, ones(1, npnts) ); % cellicize
    D2b = squeeze(D2b).'; % eliminate redundant dimensions
else
    D2b = {D2b};
end
[gd, Dgd, D2gd] = gamma_d(q, qd);
H = hes_krnf(gd, Dgd, D2gd, b, Db, D2b, k);
