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
% usage
%   [sf, sDf, sD2f] = SIGMA_FADING(f, Df, D2f)
%
% input
%   f = function values at calculation points
%     = [1 x #points]
%   Df = function gradients at calculation points (i.e., derivatives.')
%      = [#dim x #points]
%   D2f = function Hessian matrices at calculation points
%       = {1 x #points}
%       = {[#dim x #dim], ... }
%
% output
%   sf, sDf, sD2f = function and its derivatives with fading introduced
%
% See also SIGMA_SWITCH, PLOT_SIGMA_SWITCH.
%
% File:      sigma_fading.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.01.17 - 2012.07.10
% Language:  MATLAB R2012a
% Purpose:   switch value, gradient, Hessian matrix for C^2 fading switch
% Copyright: Ioannis Filippidis, 2011-

% depends
%   sigma_switch

%% function
[sf, dsf, d2sf] = sigma_switch(f);

%% gradient
% sDf = dsf *Df;
sDf = bsxfun(@times, dsf, Df);

%% Hessian matrix
% sD2f = d2sf *Df *Df.' +dsf *D2f;
[ndim, npnt] = size(Df);
a = mat2cell(Df, ndim, ones(1, npnt) );
DfDf = cellfun(@(x, y) x*y.', a, a, 'UniformOutput', false);

d2sf = num2cell(d2sf);
c1 = cellfun(@(x, y) x*y, d2sf, DfDf, 'UniformOutput', false);

dsf = num2cell(dsf);
c2 = cellfun(@(x, y) x*y, dsf, D2f, 'UniformOutput', false);
sD2f = cellfun(@(x, y) x+y, c1, c2, 'UniformOutput', false);
