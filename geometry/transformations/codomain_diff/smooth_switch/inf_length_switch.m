function [s, ds, d2s] = inf_length_switch(t)
%   exponential switch function from 0 at x=0 to 1 at +\infty
%   exp(-1/t)
%
% See also smooth_switch_normalized, smooth_switch, test_smooth_switch.
%
% File:      inf_length_switch.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.09.13
% Language:  MATLAB R2012a
% Copyright: Ioannis Filippidis, 2012-

[n, m] = size(t);
s = nan(n, m);
ds = nan(n, m);
d2s = nan(n, m);

s(t <= 0) = 0;
ds(t <= 0) = 0;
d2s(t <= 0) = 0;

t1 = t(t > 0);

s(t > 0) = exp(-1./t1);
ds(t > 0) = t1.^(-2) .*exp(-1./t1);
d2s(t > 0) = (-2 +t1.^(-1) ) .*t1.^(-3) .*exp(-1./t1);
