function [bi, Dbi] = beta_torus(q, qc, r, R, rot)
%BETA_TORUS     single torus implicit function and gradient.
%
% See also BETA_TORI, PLOT_TORUS.
%
% File:      beta_torus.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2010.11.24 - 2011.09.11
% Language:  MATLAB R2011a
% Purpose:   torus \beta_i implicit function
% Copyright: Ioannis Filippidis, 2010-

npnt = size(q, 2);

qi = rot.' *bsxfun(@minus, q, qc);

bi = nan(1, npnt);

x = qi(1, :);
y = qi(2, :);
z = qi(3, :);

nqi2 = vnorm(qi, 1, 2).^2;

bi(1, :) = (nqi2 +R^2 -r^2).^2 -4 *R^2 *(x.^2 +y.^2);
Dbi(:, 1:npnt) = 4 .*[x .*(nqi2 -R^2 -r^2);
                      y .*(nqi2 -R^2 -r^2);
                      z .*(nqi2 +R^2 -r^2) ];

bi(bi <= 0) = 1;

%bi(i, 1) = norm(q-qc, 2).^2 -r^2 ...
%          +R^2 -2 .*R .*sqrt(norm(q-qc, 2).^2 -dot(q-qc, n1).^2) ...
%          +dot(q1./norm(q1,2), n2).^2; % symmetry breaking term
