function [JT] = JTi(r, theta, ri, r_in, r_out)
%
% See also Ti, plot_T1.
%
% File:      JTi.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2010.09.16
% Language:  MATLAB R2010b
% Purpose:   Shrinking transformation Jacobian matrix
% Copyright: Ioannis Filippidis, 2010-

x = (r - r_in) /(r_out - r_in);

bi = (r - r_in) /ri + 1;
dbi = 1 /ri;

s = sigma_switch(x);
ds = dsigma_switch(x);

% analytical
T1r = ds /(r_out - r_in) * (bi*ri - r) + s *dbi *ri + 1 - s;

JT = [T1r, nan;
        0,   1];
