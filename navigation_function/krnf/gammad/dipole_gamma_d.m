function [gd, Dgd, D2gd] = dipole_gamma_d(q, qd, nx, R, m)
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
% File:      dipole_gamma_d.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.11.26 - 
% Language:  MATLAB R2011b
% Purpose:   electric dipole destination attractive function & derivatives:
%            \gamma_d, \nabla\gamma_d, \nabla^2\gamma_d
% Copyright: Ioannis Filippidis, 2011-

q_qd = bsxfun(@minus, q, qd);
[ndim, npnt] = size(q_qd);

r = vnorm(q_qd, 1, 2);
nq_qd = normvec(q_qd, 1, 2);
t = dot(nq_qd, repmat(nx, 1, npnt), 1);

gd = r +R .*tanh(m .*r) .*sin(t).^2;
polar_Dgd = [(1 +m .*R .*(1 -tanh(m .*r).^2) .*sin(t).^2);
             (R .*tanh(m .*r) .*cos(2 .*t) ) ];

Dgd = pol2cart_vector(r, t, polar_Dgd);

D2gd = 'not yet implemented';
