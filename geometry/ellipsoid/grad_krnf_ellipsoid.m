function [gradnf] = grad_krnf_ellipsoid(x, xd, k, xc, A, R)
% xc = cell(#obstacles, 1) = ellipsoid centers
% A = cell(#obstacles, 1) = ellipsoid definition matrices
% R = cell(#obstacles, 1) = ellipsoid axes rotation matrices
%
% File:      grad_krnf_ellipsoid.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.09.10
% Language:  MATLAB R2010b
% Purpose:   GRAD_KRNF for a set of ellipse obstacles
% Copyright: Ioannis Filippidis, 2011-

no = size(xc, 1);

bi = nan(no, 1);
Dbi = cell(no, 1);
for i=1:no
    curxc = xc{i, 1};
    curA = A{i, 1};
    curR = R{i, 1};

    [b1, Db1] = beta_quadric(x, curxc, curR, curA);
    bi(i, 1) = b1;
    Dbi{i, 1} = Db1;
end

gradnf = grad_krnf(x, xd, bi, Dbi, k);
