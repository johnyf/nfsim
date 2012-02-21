function [sf, sDf, sD2f] = sigma_fading(f, Df, D2f)
%SIGMA_FADING   to be used before combination (e.g. with product or
%   Boolean operations using Rvachev functions) of obstacles, to make
%   each individual obstacle affect a finite neighborhood. In this way
%   obstacles do not affect the regions of free space that are far away
%   from them. In addition, if the constant value of \beta_i, which is
%   achieved after this switch applies fading, is equal to 1, then the
%   obstacle function is "normalized". This proves to be a nice numerical
%   property.
%
%   Moreover, applying varying neighborhoods as a substitute for tuning
%   can be done by scaling \beta_i before feeding it to this switch, or by
%   an affine transformation of \beta_i values before feeding them to the
%   switch.
%
% See also SIGMA_SWITCH, DSIGMA_SWITCH, D2SIGMA_SWITCH, PLOT_SIGMA_SWITCH.
%
% File:      sigma_fading.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.01.17 - 2012.02.21
% Language:  MATLAB R2011b
% Purpose:   switch value, gradient, Hessian matrix for C^2 fading switch
% Copyright: Ioannis Filippidis, 2011-

sf = sigma_switch(f);
dsf = dsigma_switch(f);

sDf = dsf *Df;

sD2f = d2sigma_switch(f) *(Df *Df.') +dsf *D2f;
