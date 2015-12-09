function [sigma, dsigma, d2sigma] = smooth_switch_normalized(u)
%
% smooth exponential-based switch from 0 at x=0 to 1 at x=1
%   s(u) /(s(u) +s(1 -u) ), where: s(t) = exp(-1/t)
%
% See also smooth_switch, inf_length_switch, test_smooth_switch.
%
% File:      smooth_switch_normalized.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.09.13
% Language:  MATLAB R2012a
% Copyright: Ioannis Filippidis, 2012-

[s, ds, d2s] = inf_length_switch(u);
[s1, ds1, d2s1] = inf_length_switch(1 -u);

sigma = s ./(s +s1);
dsigma = (s1 .*ds +s .*ds1) .*(s +s1).^(-2);
d2sigma = (s1 .*d2s -s .*d2s1) .*(s +s1).^(-2)...
         -2 .*(s1 .*ds +s .*ds1) .*(ds -ds1) .*(s +s1);
