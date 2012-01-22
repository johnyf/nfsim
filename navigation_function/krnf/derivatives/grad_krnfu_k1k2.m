function [grad] = grad_krnfu_k1k2(gd, Dgd, b, Db, k1, k2)
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
%   k = NF tuning parameter
%     >= 2
%
% outputs
%   grad = KRNFU gradient at poitns q
%        = [#dim x #points]
%
% See also KRNFU, GRAD_SPLINE_KRNFU, GRAD_KRNF.
%
% File:      grad_krnfu_k1k2.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.11.29
% Language:  MATLAB R2011b
% Purpose:   Koditschek-Rimon unsquashed Navigation Function with 2 tuning
%            exponents: k1, k2, such that:
%            \hat{\phi} = \frac{\gamma_d^{k_1} }{\beta^{k_2} }
% Copyright: Ioannis Filippidis, 2011-

check_krnf_args(gd, b, k)

c = gd.^k1 .*b.^(-k2);
v = bsxfun(@times, Dgd, k1 ./gd) -bsxfun(@times, Db, k2 ./b);

grad = bsxfun(@times, v, c);
