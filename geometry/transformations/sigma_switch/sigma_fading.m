function [sf, sDf, sD2f] = sigma_fading(f, Df, D2f)
% File:      sigma_fading.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.01.17
% Language:  MATLAB R2011b
% Purpose:   obstacle C^2-smooth switch, gradient and Hessian matrix
% Copyright: Ioannis Filippidis, 2011-

sf = sigma_switch(f);
dsf = dsigma_switch(f);

sDf = dsf *Df;

sD2f = d2sigma_switch(f) *(Df *Df.') +dsf *D2f;
