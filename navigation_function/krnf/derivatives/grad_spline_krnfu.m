function [gnf] = grad_spline_krnfu(q, qd, bsp, Dbpp, k)
% input
%   q = calculation points
%     = [#dimensions x #points]
%   qd = desired destination
%      = [#dimensions x 1]
%   bsp = obstacle function
%           B-spline structure
%           (B form, see Curve Fitting Toolbox)
%   Dbpp = obstacle function gradient
%           spline structure
%           (PP form, see Curve Fitting Toolbox)
%   k = NF tuning parameter
%     >= 2
%
% output
%   gnf = KRNFU gradient at points q
%       = [#dim x #points]
%
% See also SPLINE_KRNFU, GRAD_SPLINE_KRNF.
%
% File:      grad_spline_krnfu.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.08.30
% Language:  MATLAB R2011a
% Purpose:   Koditschek-Rimon Unsquashed Navigation Function Gradient
%            Analytically for B-spline obstacle function
% Copyright: Ioannis Filippidis, 2011-

b = fnval(bsp, q);
Db = fnval(Dbpp, q);
[gd, Dgd] = gamma_d(q, qd);
gnf = grad_krnfu(gd, Dgd, b, Db, k); % unsquashed
