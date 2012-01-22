function [gammadimin] = gdimin_calc(i, qd, qi, ri, ei)
% File:      gdimin_calc.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.02.27 - 2011.07.30
% Language:  MATLAB R2011a
% Purpose:   \min_{\overline{\mathcal{B}_i(\varepsilon_i) } }\{\gamma_d \}
% Copyright: Ioannis Filippidis, 2011-

if i==0
    error('only i>0')
else
    gammadimin = (sqrt(ei +ri^2) -norm(qi-qd, 2) )^2;
end
