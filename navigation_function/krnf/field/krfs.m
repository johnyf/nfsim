function [nfs] = krfs(q, qd, qc, r0, r, k)
%KRFS Koditschek-Rimon function optimized for sphere worlds.
%
% Parameter k selected either:
%   1) manually,
%   2) CALCULATED INDEPENDENTLY according to extension of original proof,
%   3) CALCULATED INDEPENDENTLY according to simple (but effective)
%      feedback law.
%
% usage
%   nfs = KRFS(q, qd, qc, r0, r, k)
%
% inputs
%   q = calculation points
%     = [#dimensions x #points]
%   qd = single destination
%      = [#dimensions x 1]
%   qc = sphere centers
%      = [#dimensions x #internal_spheres]
%   r0 = world radius (scalar, if known, otherwise pass r0 < 0)
%       Note: 0-sphere assumed to be centered at the origin of q.
%   r = sphere radii
%     = [1 x #internal_spheres]
%   k = tuning parameter (scalar >2 and >(#internal spheres)
%       if unbounded world)
%
% outputs
%   nfs = KRFS at points q
%       = [1 x #points]
%
% 2010.08.20 - 2011.09.11 (c) Ioannis Filippidis, jfilippidis@gmail.com
%
% See also NORMALIZED_GRAD_KRFS, KRF.

% todo
%   check that r0 works well when NOT defined, i.e. when r0<0

%% NO obstacle known
if isempty(qc) && (r0 <= 0)
    gd = gamma_d(q, qd);
    nfs = gd ./(gd +1);
    return
end

%% some obstacles known
check_krnfs_args(q, qd, qc, r0, r, k)

gd = gamma_d(q, qd);
b = beta0toM(q, qc, r0, r);

% nf values (many q)
if k < 100
    nfs = gd ./(gd.^k + b).^(1/k);
    
    % w/o squashing diffeomorphism, as in internals of original proof
    %phis = bsxfun(@rdivide, gammad.^k, beta);
else
    nfs = ones(size(gd) ); % too large a power to compute, so plot is approximately ok
    nfs(1, gd < 0.1) = gd(1, gd < 0.1); % avoid 3D singleton aspect ratio
end

function [b] = beta0toM(q, qc, r0, r)
% obstacle 0 (many q, single O0)
normq = vnorm(q, 1, 2).^ 2;
b = ones(size(normq) );
if r0 >= 0
    b = r0.^2 - normq;
end

% obstacles 1,...,M (single q, many qc)
if ~isempty(r)
    for i=1:size(q,2)
        q_qc = bsxfun(@minus, q(:,i), qc);
        bi = vnorm(q_qc, 1, 2).^2 -r.^2;
        b(1,i) = b(1,i) .*prod(bi);
    end
end

b(b < 0) = 0;

if isempty(find(b == 0, 1) ) == 0
    %warning('Configuration q or goal qg within obstacle!')
end
