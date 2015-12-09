function [f, df, d2f] = smooth_switch(x, x1, e)
%SMOOTH_SWITCH  Smooth switch function with compact support.
%
% usage
%   [f, df, d2f] = SMOOTH_SWITCH(x, x1, e)
%
% input
%   x = independent variable
%   x1 = lower threshold at which transition from 0 to 1 starts
%   e = length of transition interval
%
% output
%   f = transition switch function values at x
%     = s(u) /(s(u) +s(1 -u) ), where: u(x)=(x-x1) /e, and: s(t)=exp(-1/t)
%   df = derivative of transition switch
%   d2f = 2nd derivative of transition switch
%
% reference
%   Loizou S.
%   Navigation Functions in Topologically Complex 3-D Workspaces
%   ACC 2012, p.3
%
% See also test_smooth_switch, smooth_switch_normalized, inf_length_switch.
%
% File:      smooth_switch.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.09.13
% Language:  MATLAB R2012a
% Copyright: Ioannis Filippidis, 2012-

%% init
[n, m] = size(x);

f = nan(n, m);
df = nan(n, m);
d2f = nan(n, m);

%% calc
u = (x -x1) /e;

f(u <= 0) = 0;
df(u <= 0) = 0;
d2f(u <= 0) = 0;

u1 = u(u > 0);

[s, ds, d2s] = smooth_switch_normalized(u1);

f(u > 0) = s;
df(u > 0) = ds /e;
d2f(u > 0) = d2s /e^2;
