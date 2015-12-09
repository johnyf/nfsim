function [nf] = spline_krfu(q, qd, bsp, k)
%SPLINE_KRFU    Unsquashed Koditschek-Rimon function with B-spline obstacle
%
% usage
%   nf = SPLINE_KRFU(q, qd, bsp, k)
%
% input
%   q = calculation points
%     = [#dim x #points]
%   qd = desired destination
%      = [#dim x 1]
%   bsp = obstacle function
%        B-spline structure
%        (B form, see Curve Fitting Toolbox)
%   k = NF tuning parameter
%     >= 2
%
% output
%   nf = KRFU values at q
%      = [1 x #points]
%
% 2011.08.30 (c) Ioannis Filippidis, jfilippidis@gmail.com
%
% See also SPLINE_KRF, KRF.

b = fnval(bsp, q);
gd = gamma_d(q, qd);
nf = krnfu(gd, b, k); % unsquashed
