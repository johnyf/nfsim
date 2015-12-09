function [gnf] = grad_spline_krf(q, qd, bsp, Dbpp, k)
% Gradient of Koditschek-Rimon function for B-spline obstacle function
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
%           spline structure
%           (PP form, see Curve Fitting Toolbox)
%   k = KRf tuning parameter
%     >= 2
%
% outputs
%   gnf = gradient at q
%       = [#dim x #points]
%
% 2011.08.30 - 2011.09.10 (c) Ioannis Filippidis, jfilippidis@gmail.com
%
% See also SPLINE_KRF, GRAD_SPLINE_KRFU.

b = fnval(bsp, q);
Db = fnval(Dbpp, q);
[gd, Dgd] = gamma_d(q, qd);
gnf = grad_krf(gd, Dgd, b, Db, k); % classic KR
