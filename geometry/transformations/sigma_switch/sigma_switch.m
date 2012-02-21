function [s] = sigma_switch(x)
%
% See also DSIGMA_SWITCH, D2SIGMA_SWITCH, PLOT_SIGMA_SWITCH.
%
% File:         sigma_switch.m
% Author:       Ioannis Filippidis, jfilippidis@gmail.com
% Date:         2010.09.15 - 2012.01.17
% Language:     MATLAB R2011b
% Purpose:      C^2-smooth switch
% Copyright:    Ioannis Filippidis, 2010-

polycoef = [-6, +15, -10, 0, 0, +1];
[lt0, gt1, in01] = sigma_intervals(x);

s = nan(size(x) );
s(lt0) = 1;
s(gt1) = 0;
s(in01) = polyval(polycoef, x(in01) );
