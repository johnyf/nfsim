function [y, m] = circle_geometric_inverse(x, r, x0, r0)
%CIRCLE_GEOMETRIC_INVERSE   Inverse of a circle.
%
% usage
%   [y, m] = CIRCLE_GEOMETRIC_INVERSE(x, r, x0, r0)
%
% input
%   x = original circle center point
%     = [2 x 1]
%   r = original circle radius
%     > 0
%   x0 = inversion circle center point
%      = [2 x 1]
%   r0 = inversion circle radius
%      > 0
%
% output
%   y = inverted circle center point
%     = [2 x 1]
%   m = inverted circle radius
%     > 0
%
% 2013.01.25 Copyright Ioannis Filippidis
%
% See also geometric_inversion, test_circle_geometric_incerse.

d = norm(x-x0, 2);
s = r0^2 /(d^2 -r^2);

m = abs(s) *r;
y = x0 +s *(x -x0);
