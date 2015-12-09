function [grad] = grad_krf(gd, Dgd, b, Db, k)
%GRAD_KRF   Koditschek-Rimon function gradient (analytical)
%
%usage
%-----
%   grad = GRAD_KRF(gd, Dgd, b, Db, k)
%
%input
%-----
%   gd = destination function values @ calculation points
%     = [#dimensions x #points]
%   Dgd = destination function gradients @ calculation points
%      = [#dimensionas x 1]
%   b = product obstacle function values @ calculation points
%      = [1 x #points]
%   Db = product obstacle function gradients @ calculation points
%       = [#dim x #points]
%   k = KRf tuning parameter
%     >= 2
%
%output
%------
%   grad = KRf gradients @ calculation points
%        = [#dim x #points]
%
%about
%-----
% 2011.06.03 - 2011.11.27 (c) Ioannis Filippidis, jfilippidis@gmail.com
%
% See also krf, grad_krfu, grad_spline_krf.

check_krf_args(gd, b, k)

c = (gd.^k +b).^(-1/k -1);
v = bsxfun(@times, Dgd, b) -bsxfun(@times, Db, gd /k);

grad = bsxfun(@times, v, c);
grad(:, b <= 0) = nan;
