function [lt0, gt1, in01] = sigma_intervals(x)
%
% See also SIGMA_FADING.
%
% File:      sigma_intervals.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.01.17
% Language:  MATLAB R2011b
% Purpose:   indices of elements of x<=0, 0<x<1, 1<=x
% Copyright: Ioannis Filippidis, 2012-

lt0 = (x <= 0);
gt1 = (1 <= x);
in01 = and(0 < x, x < 1);
