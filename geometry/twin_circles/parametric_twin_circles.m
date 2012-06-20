function [r] = parametric_twin_circles(theta, qc, rho)
%PARAMETRIC_TWIN_CIRCLES   Parametric curve of twin circle union.
%
% usage
%   r = PARAMETRIC_LEMNISCATE_BOOTH(theta, xc, r)
%
% input
%   theta = polar angle coordinates of calculation points
%         = [1 x #points]
%   qc = right-half plane circle center point
%      = [xc, yc].'
%   rho = circle radius
%       > 0
%
% output
%   r = polar radius coordinates of calculation points
%     = [1 x #points]
%
% See also PLOT_TWIN_CIRCLES, BETA_TWIN_CIRCLES, TEST_TWIN_CIRCLES.
%
% File:      parametric_twin_circles.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.05.22
% Language:  MATLAB R2012a
% Purpose:   parametric curve of twin circle union
% Copyright: Ioannis Filippidis, 2012-

%% calc
% right-half plane circle
[tc, rc] = vcart2pol(qc);
t2 = theta -tc;
r2 = rc .*cos(t2) +sqrt(rho^2 -rc^2 .*sin(t2).^2);

% left-half plane circle
qc(1, 1) = -qc(1, 1);
[tc, rc] = vcart2pol(qc);
t1 = theta -tc;
r1 = rc .*cos(t1) +sqrt(rho^2 -rc^2 .*sin(t1).^2);

idx1 = find(cos(theta) < 0);
idx2 = find(0 <= cos(theta) );

r = theta;
r(1, idx1) = r1(1, idx1);
r(1, idx2) = r2(1, idx2);
