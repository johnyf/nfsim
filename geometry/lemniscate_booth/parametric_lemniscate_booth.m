function [r] = parametric_lemniscate_booth(theta, a, r0)
%PARAMETRIC_LEMNISCATE_BOOTH   Parametric Booth leminiscate curve.
%
% usage
%   r = PARAMETRIC_LEMNISCATE_BOOTH(theta)
%   r = PARAMETRIC_LEMNISCATE_BOOTH(theta, a, r0)
%
% input
%   theta = polar angle coordinates of calculation points
%         = [1 x #points]
%
% optional input
%   a = leminiscate axis ratio
%     > 0
%   r0 = leminiscate scale
%      > 0
%
% output
%   r = polar radius coordinates of calculation points
%     = [1 x #points]
%
% See also PLOT_LEMNISCATE_BOOTH, BETA_LEMNISCATE_BOOTH,
%          TEST_LEMNISCATE_BOOTH.
%
% File:      parametric_lemniscate_booth.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.05.21
% Language:  MATLAB R2012a
% Purpose:   parametric Booth Leminiscate curve
% Copyright: Ioannis Filippidis, 2012-

%% input
if nargin < 2
    a = 0.8;
end

if nargin < 3
    r0 = 1;
end

%% calc
r = r0 *sqrt(1 -a *sin(theta).^2);
