function [q, x1, x2] = parametric_ellipse(q, qc, a, b, coor)
%PARAMETRIC_ELLIPSE     Parametric ellipse equation.
%   (cartesian input, cartesian/polar output)
%
% usage
%   q = PARAMETRIC_ELLIPSE(theta, qi, a, b, phi)
%
% input
%   theta = polar angle
%   qi = ellipse center
%   a = major semi-radius
%   b = minor semi-radius
%
% See also POLAR_PARAMETRIC_ELLIPSE, PLOT_ELLIPSOID.
%
% File:      parametric_ellipse.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.05.24
% Language:  MATLAB R2012a
% Purpose:   Parametric ellipse equation in cartesian coordinates with
%            either polar or cartesian output
% Copyright: Ioannis Filippidis, 2012-

% depends
%   global2local_cart, local2global_cart, vcart2pol, vpol2cart,
%   polar_parametric_ellipse

q_qc = global2local_cart(q, qc);
theta = vcart2pol(q_qc);

r = polar_parametric_ellipse(theta, a, b);

switch coor
    case 'cartesian'
        q = vpol2cart(theta, r);
        q = local2global_cart(q, qc);
        x1 = q(1, :);
        x2 = q(2, :);
    case 'polar'
        q = [theta; r];
        x1 = theta;
        x2 = r;
    otherwise
        error('ellipse:coor', 'Unknown coordinate system for output.')
end