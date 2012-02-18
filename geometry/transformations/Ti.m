function [T] = Ti(r, theta, ri, r_in, r_out)
% File:      Ti.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2010.09.15
% Language:  MATLAB R2010b
% Purpose:   Shrinking transformation
% Copyright: Ioannis Filippidis, 2010-

x = (r - r_in) /(r_out - r_in);
bi = (r - r_in) /ri + 1; % correct

s = S(x);

T = [s *bi *ri + (1-s) * r;
     theta];
