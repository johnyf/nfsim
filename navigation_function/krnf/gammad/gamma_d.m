function [gd, Dgd, D2gd] = gamma_d(q, qd)
% inputs:
%   q = (multiple) calculation points
%     = [#dimensions x #points]
%   qd = single destination
%        [#dimensions x 1]
%
% outputs:
%   gd = function values at calculation points
%      = [1 x #points]
%   Dgd = function gradients at calculation points
%       = [#dimensions x #points]
%   D2gd = function Hessian matrices at calculation points
%        = {1 x #points}
%
% File:      gamma_d.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.06.13 - 2011.11.26
% Language:  MATLAB R2011b
% Purpose:   paraboloid destination attractive function and derivatives:
%            \gamma_d, \nabla\gamma_d, \nabla^2\gamma_d
% Copyright: Ioannis Filippidis, 2011-

check_qqd(q, qd)

q_qd = bsxfun(@minus, q, qd);
[ndim, npnt] = size(q_qd);

gd = vnorm(q_qd, 1, 2).^2;

if nargout >= 2
    Dgd = 2 *q_qd;
end

if nargout >= 3
    D2gd = {2 *eye(ndim) };
    D2gd = repmat(D2gd, 1, npnt);
end
