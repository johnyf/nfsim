function [ds] = dsigma_switch(x)
%
% See also SIGMA_SWITCH, D2SIGMA_SWITCH, PLOT_SIGMA_SWITCH.
%
% File:      dsigma_switch.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2010.09.15 - 2012.01.17
% Language:  MATLAB R2011b
% Purpose:   C^2-smooth switch derivative
% Copyright: Ioannis Filippidis, 2010-

polycoef = [-30, +60, -30, 0, 0];
[lt0, gt1, in01] = sigma_intervals(x);

ds = nan( size(x) );
ds(lt0) = 0;
ds(gt1) = 0;
ds(in01) = polyval(polycoef, x(in01) );
