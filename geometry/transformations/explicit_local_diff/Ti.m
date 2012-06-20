function [T] = Ti(theta, r, r_in, r_out, rho)
%
% See also JTI, PLOT_T1.
%
% File:      Ti.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2010.09.15
% Language:  MATLAB R2010b
% Purpose:   Shrinking transformation
% Copyright: Ioannis Filippidis, 2010-

% depends
%   sigma_switch

x = (r -r_in) ./(r_out -r_in);
bi = (r -r_in) ./rho + 1; % correct

s = sigma_switch(x);

T = [s .*bi *rho + (1-s) .*r;
     theta];
