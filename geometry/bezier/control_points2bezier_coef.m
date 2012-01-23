function [a] = control_points2bezier_coef(xcp)
% File:      control_points2bezier_coef.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2010.09.13
% Language:  MATLAB R2010b
% Purpose:   given bezier control points
%            return bezier parametric polynomials coefficients
%            Note: based on bezier_curve.c by John Filippidis (c) 2008
% Copyright: Ioannis Filippidis, 2010-
%
% xcp = [xcp1, xcp2, ..., xcpN+1]
% xcpi = [x1i, x2i, x3i]

a = xcp * m_calc( size(xcp,2) );
a = fliplr(a); % make it compatible with matlab polynomials
