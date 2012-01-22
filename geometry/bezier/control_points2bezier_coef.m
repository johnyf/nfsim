% File:         control_points2bezier_coef.m
% Programmer:   John Filippidis, Mechanical Engineer, jfilippidis@gmail.com
% Date:         2010.09.13
% Language:     MATLAB, program version: 7.11 (2010b)
% Purpose:      given bezier control points
%               return bezier parametric polynomials coefficients
%               Note: based on bezier_curve.c by John Filippidis (c) 2008
% Copyright:    John Filippidis, 2010-

% xcp = [xcp1, xcp2, ..., xcpN+1]
% xcpi = [x1i, x2i, x3i]

function [a] = control_points2bezier_coef(xcp)
    a = xcp * m_calc( size(xcp,2) );
    a = fliplr(a); % make it compatible with matlab polynomials
end
