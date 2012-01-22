function [ei3j] = ei3j_calc(qci, qcj, ri, rj)
% File:      ei3j_calc.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.02.27 - 
% Language:  MATLAB R2011a
% Purpose:   \varepsilon_{i3j}
% Copyright: Ioannis Filippidis, 2011-

dij = norm(qci -qcj, 2);
ei3j = (dij -rj)^2 -ri^2;
