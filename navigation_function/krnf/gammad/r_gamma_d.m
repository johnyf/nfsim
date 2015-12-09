function [gd, Dgd, D2gd] = r_gamma_d(q, qd)
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
% File:      r_gamma_d.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.05.11
% Language:  MATLAB R2012a
% Purpose:   
% Copyright: Ioannis Filippidis, 2011-

check_qqd(q, qd)

q_qd = bsxfun(@minus, q, qd);
[ndim, npnt] = size(q_qd);

gd = vnorm(q_qd, 1, 2);

if nargout >= 2
    Dgd = normvec(q_qd, 'p', 2, 'dim', 1);
end

if nargout >= 3
    for i=1:npnt
        curq_qd = q_qd(:, i);

        x = curq_qd(1, 1);
        y = curq_qd(2, 1);

        [r, theta] = cart2pol(x, y);

        curD2gd = [sin(theta)^2, -sin(2*theta)/2; -sin(2*theta)/2, cos(theta)^2] /r;
        D2gd{1, i} = curD2gd;
    end
end
