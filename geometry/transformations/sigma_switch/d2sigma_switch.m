function [d2s] = d2sigma_switch(x)
% File:      d2sigma_switch.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2010.09.15 - 2012.01.17
% Language:  MATLAB R2011b
% Purpose:   C^2-smooth switch 2nd derivative
% Copyright: Ioannis Filippidis, 2010-

polycoef = [-120, +180, -60, 0];
[lt0, gt1, in01] = sigma_intervals(x);

d2s = nan( size(x) );
d2s(lt0) = 0;
d2s(gt1) = 0;
d2s(in01) = polyval(polycoef, x(in01) );
