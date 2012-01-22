% File:      incloseddisk.m
% Author:    Ioannis Filippidis, Mechanical Engineer, jfilippidis@gmail.com
% Date:      2010.12.21 - 
% Language:  MATLAB, program version: 7.11 (2010b)
% Purpose:   check if point in interior of open disk or on its boundary
% Copyright: Ioannis Filippidis, 2010-

function [within] = incloseddisk(x1, x2, r)
if norm(x1-x2, 2) <= r
    within = 1;
else
    within = 0;
end
