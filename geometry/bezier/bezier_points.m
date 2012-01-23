function [xb] = bezier_points(bezier_coef, t)
% File:      bezier_points.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2010.09.13
% Language:  MATLAB R2010b
% Purpose:   given bezier coefficients and parameter t values
%            return bezier curves corresponding to given t values
%            Note: based on bezier_curve.c by Ioannis Filippidis (c) 2008
% Copyright: Ioannis Filippidis, 2010-

xb = zeros( size(bezier_coef,1), length(t) );

for i=1:size(bezier_coef,1)
    xb(i,:) = polyval(bezier_coef(i,:), t);
end
