% File:      Ti.m
% Author:    Ioannis Filippidis, Mechanical Engineer, jfilippidis@gmail.com
% Date:      2010.09.15
% Language:  MATLAB, program version: 7.11 (2010b)
% Purpose:   Shrinking transformation
% Copyright: Ioannis Filippidis, 2010-

function [T] = Ti(r, theta, ri, r_in, r_out)
x = (r - r_in) /(r_out - r_in);
bi = (r - r_in) /ri + 1; % correct

s = S(x);

T = [s *bi *ri + (1-s) * r;
     theta];
