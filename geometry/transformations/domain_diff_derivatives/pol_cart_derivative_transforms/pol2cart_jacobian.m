function [vcart] = pol2cart_jacobian(r, t, vpol)
% File:      pol2cart_jacobian.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.12.25 - 
% Language:  MATLAB R2011b
% Purpose:   polar to Cartesian vector transformation
% Copyright: Ioannis Filippidis, 2011-

JTrow1 = [cos(t); -sin(t) ./r];
JTrow2 = [sin(t); cos(t) ./r];

vcart = [dot(JTrow1, vpol, 1); dot(JTrow2, vpol, 1) ];
