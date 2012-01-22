% File:      P.m
% Author:    Ioannis Filippidis, Mechanical Engineer, jfilippidis@gmail.com
% Date:      2010.09.15
% Language:  MATLAB, program version: 7.11 (2010b)
% Purpose:   Obstacle 1/repulsive potential
% Copyright: Ioannis Filippidis, 2010-

function [P] = P(x)
P = polyval( [0.5, -2.5/3, 0.5, -1.5, 7/3, 0], x);
