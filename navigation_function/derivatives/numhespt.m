function [pt] = numhespt(q, h)
% File:      numhespt.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.07.30
% Language:  MATLAB R2011a
% Purpose:   Numerical Hessian Function values calculation points
% Copyright: Ioannis Filippidis, 2011-
%
% q = single calculation point
%   = [#dimensions x 1]
% h = perturbation scalar
%       In case different steps are taken in each direction give the array
%       of steps (#dimensions x 1)
%
% output
%   pt = [q, q1, q2, ..., qndim, q1, q11, q12, ..., q1ndim, ..., qndimndim]
%      = [#dimensions x (#dimensions +1) ]
%      These are the points where the function value should be calculated
%      before calculatin gthe numerical Hessian of the function.
%       1) Point q is the current point and q1, q2, ..., qndim are
%          perturbed ones. This first set of (ndim +1) points is used to
%          calculate numerically the gradient at q.
%       2) At each q1, q2, ..., qndim, we have e.g.
%          q1 the nearby point, q11, q12, ..., q1ndim the perturbations
%          from point q1. These are used to calculate the gradient at q1.

ndim = size(q, 1);
pt = zeros(ndim, (ndim +1)^2 );
pt(:, 1:(ndim +1) ) = numgradpt(q, h);
for i=1:ndim
    i1 = i *(ndim +1);
    idx = 1:(ndim +1);
    qcur = pt(:, i +1);
    pt(:, i1 +idx) = numgradpt(qcur, h);
end
