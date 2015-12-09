function [grad] = grad_krfu(gd, Dgd, b, Db, k)
%GRAD_KRFU     Un-squashed Koditschek-Rimon function gradient.
%
% usage
%   grad = GRAD_KRFU(gd, Dgd, b, Db, k)
%
% input
%   q = calculation points
%     = [#dimensions x #points]
%   qd = destination point
%      = [#dimensionas x 1]
%   bi = obstacle function values at points q
%      = [#obstacles x #points]
%   Dbi = obstacle function gradients at points q
%       = cell(#obstacles, 1)
%       = {[#dim x #points]; ...}
%   k = KRf tuning parameter
%     >= 2
%
% output
%   grad = KRFU gradient at poitns q
%        = [#dim x #points]
%
% 2011.07.31 - 2011.11.29 (c) Ioannis Filippidis, jfilippidis@gmail.com
%
% See also KRFU, GRAD_SPLINE_KRFU, GRAD_KRF, GRAD_SPLINE_KRF.

check_krf_args(gd, b, k)

c = gd.^k .*b.^(-2);
v = bsxfun(@times, Dgd, k .*b .*gd.^(-1) ) -Db;

grad = bsxfun(@times, v, c);
