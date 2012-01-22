% File:      JTi.m
% Author:    Ioannis Filippidis, Mechanical Engineer, jfilippidis@gmail.com
% Date:      2010.09.16
% Language:  MATLAB, program version: 7.11 (2010b)
% Purpose:   Shrinking transformation Jacobian matrix
% Copyright: Ioannis Filippidis, 2010-

function [JT] = JTi(r, theta, ri, r_in, r_out)
x = (r - r_in) /(r_out - r_in);

bi = (r - r_in) /ri + 1;
dbi = 1 /ri;

s = S(x);
ds = dS(x);

% analytical
T1r = ds /(r_out - r_in) * (bi*ri - r) + s *dbi *ri + 1 - s;

JT = [T1r, nan;
        0,   1];
