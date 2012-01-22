function [nf] = spline_krnfu(q, qd, bsp, k)
% input
%   q = calculation points
%     = [#dim x #points]
%   qd = desired destination
%      = [#dim x 1]
%   bsp = obstacle function
%        B-spline structure
%        (B form, see Curve Fitting Toolbox)
%   k = NF tuning parameter
%     >= 2
%
% output
%   nf = KRNFU values at q
%      = [1 x #points]
%
% See also SPLINE_KRNF, KRNF.
%
% File:      krnfu.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.08.30
% Language:  MATLAB R2011a
% Purpose:   Koditschek-Rimon Unsquashed Navigation Function for
%            General Worlds and B-spline obstacle function
% Copyright: Ioannis Filippidis, 2011-

b = fnval(bsp, q);
gd = gamma_d(q, qd);
nf = krnfu(gd, b, k); % unsquashed
