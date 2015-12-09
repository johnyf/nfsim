function [r] = parametric_lemniscate_booth2(theta, a, b, e)
%PARAMETRIC_LEMNISCATE_BOOTH2   Parametric Booth leminiscate curve.
%   The difference with plot_lemniscate_booth is that here the
%   lemniscate parameters are a, b and the eccentricity e.
%
% usage
%   r = PARAMETRIC_LEMNISCATE_BOOTH2(theta)
%   r = PARAMETRIC_LEMNISCATE_BOOTH2(theta, a, r0)
%
% input
%   theta = polar angle coordinates of calculation points
%         = [1 x #points]
%
% optional input
%   a = leminiscate semi-major axis
%     > 0
%   b = lemniscate (minor semi-radius /sqrt(eccentricity) )
%     > 0
%   e = lemniscate eccentricity
%
% output
%   r = polar radius coordinates of calculation points
%     = [1 x #points]
%
% See also PLOT_LEMNISCATE_BOOTH2, PLOT_LEMNISCATE_BOOTH,
%          PARAMETRIC_LEMNISCATE_BOOTH, BETA_LEMNISCATE_BOOTH,
%          TEST_LEMNISCATE_BOOTH.
%
% File:      parametric_lemniscate_booth2.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.05.23
% Language:  MATLAB R2012a
% Purpose:   parametric Booth Leminiscate curve
% Copyright: Ioannis Filippidis, 2012-

%% input
if nargin < 2
    a = 0.8;
end

if nargin < 3
    b = 0.4;
end

if nargin < 4
    e = 0.7;
end

%% calc
r = sqrt(a^2 *cos(theta).^2 +e *b^2 *sin(theta).^2);
