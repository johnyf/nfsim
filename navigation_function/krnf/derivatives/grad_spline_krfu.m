function [grad] = grad_spline_krfu(q, qd, bsp, Dbpp, k)
% Gradient of Koditschek-Rimon unsquashed function for B-spline obstacle
%
% usage
%   gnf] = grad_spline_krfu(q, qd, bsp, Dbpp, k)
%
% input
%   q = calculation points
%     = [#dimensions x #points]
%   qd = desired destination
%      = [#dimensions x 1]
%   bsp = obstacle function
%           B-spline structure
%           (B form, see Curve Fitting Toolbox)
%   Dbpp = obstacle function gradient
%           spline structure
%           (PP form, see Curve Fitting Toolbox)
%   k = KRf tuning parameter
%     >= 2
%
% output
%   gnf = KRFU gradient at points q
%       = [#dim x #points]
%
% See also SPLINE_KRFU, GRAD_SPLINE_KRF.
%
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.08.30

b = fnval(bsp, q);
Db = fnval(Dbpp, q);
[gd, Dgd] = gamma_d(q, qd);
grad = grad_krfu(gd, Dgd, b, Db, k); % unsquashed
