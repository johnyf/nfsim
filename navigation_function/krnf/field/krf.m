function [nf] = krf(gd, bi, k)
%KRF   Koditschek-Rimon Navigation Function for any implicit world.
%
% Parameter k selected either:
%   1) manually,
%   2) CALCULATED INDEPENDENTLY according to extension of original proof,
%   3) CALCULATED INDEPENDENTLY according to simple (but effective)
%      feedback law.
%
%usage
%-----
%   nf = KRF(gd, bi, k)
%
%input
%-----
%   gd = destination function values at calculation points
%      = [1 x #points]
%   beta = 1) Obstacle product function $\beta$ at calculation points q.
%             = [1 x #points]
%          2) Function values of all obstacles $$\beta_i$$ at caluclation
%             points q.
%             = [#obstacles x #points]
%   k = tuning parameter of KRNF
%       (scalar >2 and ># obstacles if unbounded world, see theory)
%
%output
%------
%   nf = KRF values at points q
%      = [1 x #points]
%
%about
%-----
% 2011.07.29 - 2011.09.11 (c) Ioannis Filippidis, jfilippidis@gmail.com
%
% See also GRAD_KRF, KRFU, KRFS, SPLINE_KRF.

check_krf_args(gd, bi, k)

b = bi2b(bi);
%{ experimental, when you want to see things within obstacles
%den = gd.^k + b;
%idx = and(abs(den) < eps, b < 0);
%b(1, idx) = 0; % avoid division by 0
b(b < 0) = 0;

% nf values (many q)
if k < 100
    den = gd.^k + b;
    nf = gd ./den.^(1/k);
else
    warning('kr:kval', 'Exponent k>=100, using 1 as approximation.')
    nf = ones(size(gd)); % too large a power to compute, so plot is approximately ok
    nf(1, gd < 0.1) = gd(1, gd < 0.1); % avoid 3D singleton aspect ratio
end
