function [grad] = grad_krnfu(gd, Dgd, b, Db, k)
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
% File:      grad_krnfu.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.07.31 - 2011.11.29
% Language:  MATLAB R2011a
% Purpose:   Koditschek-Rimon Unsquashed Navigation Function Gradient
%            Analytically
% Copyright: Ioannis Filippidis, 2011-

check_krnf_args(gd, b, k)

c = gd.^k .*b.^(-2);
v = bsxfun(@times, Dgd, k .*b .*gd^(-1) ) -Db;

grad = bsxfun(@times, v, c);
