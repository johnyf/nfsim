function [grad] = grad_krfu_k1k2(gd, Dgd, b, Db, k1, k2)
% warning
%   experimental
%
% Koditschek-Rimon unsquashed function with 2 tuning exponents: k1, k2,
% such that: \hat{\phi} = \frac{\gamma_d^{k_1} }{\beta^{k_2} }
%
% inputs
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
% outputs
%   grad = KRFU gradient at poitns q
%        = [#dim x #points]
%
% 2011.11.29 (c) Ioannis Filippidis, jfilippidis@gmail.com
%
% See also KRFU, GRAD_SPLINE_KRFU, GRAD_KRF.

check_krf_args(gd, b, k)

c = gd.^k1 .*b.^(-k2);
v = bsxfun(@times, Dgd, k1 ./gd) -bsxfun(@times, Db, k2 ./b);

grad = bsxfun(@times, v, c);
