function [s, ds, d2s] = sigma_switch(x)
%
% See also PLOT_SIGMA_SWITCH, SIGMA_FADING.
%
% File:         sigma_switch.m
% Author:       Ioannis Filippidis, jfilippidis@gmail.com
% Date:         2010.09.15 - 2012.05
% Language:     MATLAB R2012a
% Purpose:      C^2-smooth switch and its derivatives
% Copyright:    Ioannis Filippidis, 2010-

% depends
%   sigma_intervals

sigma_polycoef = [-6, +15, -10, 0, 0, +1];
dsigma_polycoef = [-30, +60, -30, 0, 0];
d2sigma_polycoef = [-120, +180, -60, 0];

[lt0, gt1, in01] = sigma_intervals(x);

s = nan(size(x) );
s(lt0) = 1;
s(gt1) = 0;
s(in01) = polyval(sigma_polycoef, x(in01) );

ds = nan( size(x) );
ds(lt0) = 0;
ds(gt1) = 0;
ds(in01) = polyval(dsigma_polycoef, x(in01) );

d2s = nan( size(x) );
d2s(lt0) = 0;
d2s(gt1) = 0;
d2s(in01) = polyval(d2sigma_polycoef, x(in01) );
