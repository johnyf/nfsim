% File:         bezier_points.m
% Programmer:   John Filippidis, Mechanical Engineer, jfilippidis@gmail.com
% Date:         2010.09.13
% Language:     MATLAB, program version: 7.11 (2010b)
% Purpose:      given bezier coefficients and parameter t values
%               return bezier curves corresponding to given t values
%               Note: based on bezier_curve.c by John Filippidis (c) 2008
% Copyright:    John Filippidis, 2010-

function [xb] = bezier_points(bezier_coef, t)
    xb = zeros( size(bezier_coef,1), length(t) );

    for i=1:size(bezier_coef,1)
        xb(i,:) = polyval(bezier_coef(i,:), t);
    end
end
