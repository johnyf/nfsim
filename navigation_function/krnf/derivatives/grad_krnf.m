function [grad] = grad_krnf(gd, Dgd, b, Db, k)
% inputs
%   gd = destination function values @ calculation points
%     = [#dimensions x #points]
%   Dgd = destination function gradients @ calculation points
%      = [#dimensionas x 1]
%   b = product obstacle function values @ calculation points
%      = [1 x #points]
%   Db = product obstacle function gradients @ calculation points
%       = [#dim x #points]
%   k = NF tuning parameter
%     >= 2
%
% outputs
%   grad = KRNF gradients @ calculation points
%        = [#dim x #points]
%
% See also KRNF, GRAD_KRNFU, GRAD_SPLINE_KRNF.
%
% File:      grad_krnf.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.06.03 - 2011.11.27
% Language:  MATLAB R2011a
% Purpose:   Koditschek-Rimon Navigation Function gradient Analytically
% Copyright: Ioannis Filippidis, 2011-

check_krnf_args(gd, b, k)

c = (gd.^k +b).^(-1/k -1);
v = bsxfun(@times, Dgd, b) -bsxfun(@times, Db, gd /k);

grad = bsxfun(@times, v, c);
grad(:, b <= 0) = nan;
