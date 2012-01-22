function [Qi] = Qi_calc(i, ri, x)
% File:      Qi_calc.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.05.26 - 2011.07.30
% Language:  MATLAB R2011a
% Purpose:   \Q_i(x) = \sqrt{\frac{r_i^2}{x^2} -\frac{1}{x^2} }
% Copyright: Ioannis Filippidis, 2011-

if i==0
    Qi = sqrt(ri^2 /x^2 -1 /x^2);
else
    Qi = sqrt(ri^2 /x^2 +1 /x);
end
