function [ei23] = ei23_calc(ei21, ei3)
% File:      ei23_calc.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.02.27 - 2011.07.30
% Language:  MATLAB R2011a
% Purpose:   \varepsilon_{i23}
% Copyright: Ioannis Filippidis, 2011-

ei23 = min( [ei21, ei3] );
