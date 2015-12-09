function [JT] = JTi(theta, r, r_in, r_out, rho)
%
% See also TI, PLOT_T1.
%
% File:      JTi.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2010.09.16 - 2012.05.21
% Language:  MATLAB R2012a
% Purpose:   Shrinking transformation Jacobian matrix
% Copyright: Ioannis Filippidis, 2010-

% depends
%   sigma_switch

x = (r - r_in) /(r_out - r_in);

bi = (r - r_in) /rho + 1;
dbi = 1 /rho;

[s, ds] = sigma_switch(x);

% analytical
T1r = ds /(r_out - r_in) * (bi*rho - r) + s *dbi *rho + 1 - s;

JT = [T1r, nan;
        0,   1];
