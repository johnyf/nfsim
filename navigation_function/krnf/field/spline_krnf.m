function [nf] = spline_krnf(q, qd, bsp, k)
% input:
%   q = calculation point(s)
%     = [#dim x #points]
%   qd = desired destination
%      = [#dim x 1]
%   bsp = obstacle function
%         B-spline structure
%         (B form, see Curve Fitting Toolbox)
%   k = NF tuning parameter
%     >= 2
%
% output:
%   nf = KRNF values at q
%      = [1 x #points]
%
% See also SPLINE_KRNFU, KRNF.
%
% File:      krnf.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.08.30 - 2011.09.11
% Language:  MATLAB R2011a
% Purpose:   Koditschek-Rimon Navigation Function for General Worlds
%            and B-spline obstacle function
% Copyright: Ioannis Filippidis, 2010-

b = fnval(bsp, q);
gd = gamma_d(q, qd);
nf = krnf(gd, b, k); % unsquashed
