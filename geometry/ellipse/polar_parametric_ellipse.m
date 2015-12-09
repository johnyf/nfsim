function [r] = polar_parametric_ellipse(theta, a, b)
%POLAR_PARAMETRIC_ELLIPSE   Parametric ellipse equation in polar coordinates.
%   (polar i/o)
%
% usage
%   q = POLAR_PARAMETRIC_ELLIPSE(theta, a, b)
%
% input
%   theta = polar angle
%   a = major semi-radius
%   b = minor semi-radius
%
% See also PARAMETRIC_ELLIPSE, PLOT_ELLIPSOID.
%
% File:      polar_parametric_ellipse.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.04.27 - 2012.05.24
% Language:  MATLAB R2012a
% Purpose:   Parametric ellipse equation in polar coordinates
% Copyright: Ioannis Filippidis, 2012-

r = a*b ./sqrt((b *cos(theta) ).^2 +(a *sin(theta) ).^2);
