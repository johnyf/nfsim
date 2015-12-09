function [gradf] = grad_krf_ellipsoid(x, xd, k, xc, A, R)
% GRAD_KRF for a set of ellipse obstacles
%
% usage
%   gradnf = GRAD_KRF_ELLIPSOID(x, xd, k, xc, A, R)
%
% input
%   x = coordinates of calculation points
%     = [#dim x #pnts]
%   xd = desired destination
%      = [#dim x 1]
%   k = Koditschek-Rimon function tuning parameter
%     >= 2
%   xc = ellipsoid centers
%        {#obstacles, 1}
%   A = ellipsoid definition matrices
%       {#obstacles, 1}
%   R = ellipsoid axes rotation matrices
%       {#obstacles, 1}
%
% output
%   gradnf = gradient vectors at calculation points x
%          = [#dim x #pnts]
%
% 2011.09.10 (c) Ioannis Filippidis, jfilippidis@gmail.com

no = size(xc, 1);

bi = nan(no, 1);
Dbi = cell(no, 1);
for i=1:no
    curxc = xc{i, 1};
    curA = A{i, 1};
    curR = R{i, 1};

    [b1, Db1] = beta_ellipsoid(x, curxc, curR, curA);
    bi(i, 1) = b1;
    Dbi{i, 1} = Db1;
end

gradf = grad_krf(x, xd, bi, Dbi, k);
