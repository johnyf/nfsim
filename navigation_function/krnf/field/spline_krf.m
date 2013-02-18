function [nf] = spline_krf(q, qd, bsp, k)
%SPLINE_KRF     Koditschek-Rimon function with B-spline obstacle function.
%
% usage
%   nf = SPLINE_KRF(q, qd, bsp, k)
%
% input
%   q = calculation point(s)
%     = [#dim x #points]
%   qd = desired destination
%      = [#dim x 1]
%   bsp = obstacle function
%         B-spline structure
%         (B form, see Curve Fitting Toolbox)
%   k = NF tuning parameter
%     >= 2
%
% output
%   nf = KRF values at q
%      = [1 x #points]
%
% 2011.08.30 - 2011.09.11 (c) Ioannis Filippidis, jfilippidis@gmail.com
%
% See also SPLINE_KRNFU, KRNF.

b = fnval(bsp, q);
gd = gamma_d(q, qd);
nf = krnf(gd, b, k); % unsquashed
