function [Qii] = Qii_calc(i, ri, ei)
% File:      Qii_calc.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.02.27 - 2011.07.30
% Language:  MATLAB R2011a
% Purpose:   Q_{ii}
% Copyright: Ioannis Filippidis, 2011-

if i==0
    Qii = sqrt(ri^2 /ei^2 -1 /ri^2);
else
    Qii = sqrt(ri^2 /ei^2 +1 /ei);
end
