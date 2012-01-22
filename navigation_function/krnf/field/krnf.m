function [nf] = krnf(gd, bi, k)
% Parameter k selected either:
%   1) manually,
%   2) CALCULATED INDEPENDENTLY according to extension of original proof,
%   3) CALCULATED INDEPENDENTLY according to simple (but effective)
%      feedback law.
%
% inputs:
%   gd = destination function values @ calculation points
%      = [1 x #points]
%   beta = 1) Obstacle product function \beta at calculation points q.
%             = [1 x #points]
%          2) Function values of all obstacles \beta_i at caluclation
%             points q.
%             = [#obstacles x #points]
%   k = tuning parameter of KRNF
%       (scalar >2 and ># obstacles if unbounded world, see theory)
%
% outputs
%   nf = KRNF values at points q
%      = [1 x #points]
%
% See also GRAD_KRNF, KRNFU, KRNFS, SPLINE_KRNF.
%
% File:      krnf.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.07.29 - 2011.09.11
% Language:  MATLAB R2011a
% Purpose:   Koditschek-Rimon Navigation Function for General Worlds
% Copyright: Ioannis Filippidis, 2010-

check_krnf_args(gd, bi, k)

b = bi2b(bi);
b(b < 0) = 0;

% nf values (many q)
if k < 100
    nf = gd ./(gd.^k + b).^(1/k);
else
    nf = ones(size(gd)); % too large a power to compute, so plot is approximately ok
    nf(1, gd < 0.1) = gd(1, gd < 0.1); % avoid 3D singleton aspect ratio
end
