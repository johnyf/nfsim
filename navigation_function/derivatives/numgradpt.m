function [pt] = numgradpt(q, h)
%NUMGRADPT  Numerical gradient points.
%   NUMGRADPT calculates the neighbor points where a function should be
%   first calculated before using these values to find its derivative
%   numerically (=numerical gradient, function NUMGRADNF)
%
% inputs
%   q = single calculation point
%     = [#dimensions x 1]
%
%   h = perturbation scalar
%       In case different steps are taken in each direction give the array
%       of steps
%     = [#dimensions x 1]
%
% output
%   pt = this is the current point and nearby ones perturbed by a single
%        coordinate each relative to q
%      = [q, q1, q2, ..., qndim]
%      = [#dimensions x (#dimensions +1) ]
%
% See also NUMGRAD.
%
% File:      numgradpt.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.07.30 - 2011.09.20
% Language:  MATLAB R2011a
% Purpose:   Numerical Gradient Function values calculation points
% Copyright: Ioannis Filippidis, 2011-

ndim = size(q, 1);
pt = repmat(q, [1, (ndim +1) ] );
dq = bsxfun(@times, eye(ndim), h);
pt(:, 2:end) = pt(:, 2:end) +dq;
