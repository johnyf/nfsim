function [Qji] = Qji_calc(i, j, qi, qj, ri, rj, ei)
% File:      Qji_calc.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.02.27 - 2011.07.30
% Language:  MATLAB R2011a
% Purpose:   Q_{ji}
% Copyright: Ioannis Filippidis, 2011-

% j!=i

if j==0
    minb0i = minbji_calc(i, 0, qi, qj, ri, rj, ei);
    Qji = sqrt(rj^2 /minb0i^2 -1 /rj^2);
else
    minbji = minbji_calc(i, j, qi, qj, ri, rj, ei);
    Qji = sqrt(rj^2 /minbji^2 +1 /minbji);
end
