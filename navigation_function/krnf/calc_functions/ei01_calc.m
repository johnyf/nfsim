function [ei01] = ei01_calc(lambda, qd, qc, r)
% File:      ei01_calc.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.02.27 - 2011.07.30
% Language:  MATLAB R2011a
% Purpose:   \varepsilon_{i0}'
% Copyright: Ioannis Filippidis, 2011-

qd_qc = bsxfun(@minus, qd, qc);

rdc = vnorm(qd_qc, 1, 2);

ei01 = lambda .*(rdc.^2 -r.^2);
