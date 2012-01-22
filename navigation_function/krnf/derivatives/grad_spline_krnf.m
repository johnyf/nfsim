function [gnf] = grad_spline_krnf(q, qd, bsp, Dbpp, k)
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
%   k = NF tuning parameter
%     >= 2
%
% outputs
%   gnf = gradient at q
%       = [#dim x #points]
%
% See also SPLINE_KRNF, GRAD_SPLINE_KRNFU.
%
% File:      grad_spline_krnf.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.08.30 - 2011.09.10
% Language:  MATLAB R2011a
% Purpose:   Koditschek-Rimon Navigation Function Gradient Analytically
%            for B-spline obstacle function
% Copyright: Ioannis Filippidis, 2011-

b = fnval(bsp, q);
Db = fnval(Dbpp, q);
[gd, Dgd] = gamma_d(q, qd);
gnf = grad_krnf(gd, Dgd, b, Db, k); % classic KR
