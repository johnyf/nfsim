function [X, Y, Z] = plot_torus(ax, qc, r, R, rot, npnt)
%TORUS Generate a torus.
%   PLOT_TORUS(ax, qc, r, R, rot, npnt) plots a torus with central radius
%   R and lateral radius r. npnt controls the number of facets on the
%   surface and rot is the rotation matrix of its reference frame.
%
%   [X, Y, Z] = PLOT_TORUS(ax, qc, r, R, rot, npnt) generates three
%   (npnt)-by-(npnt) matrices so that surf(X, Y, Z) will produce the torus.
%
% See also PLOT_TORI, BETA_TORUS.
%
% File:      plot_torus.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2010.12.05 - 2012.01.29
% Language:  MATLAB R2011b
% Purpose:   plot a torus
% Copyright: Ioannis Filippidis, 2010-

if nargin < 6
    npnt = 100;
end
    
% surface parameterization
theta = pi *linspace(0, 2, npnt);
phi = 2 *pi *linspace(0, 1, npnt /2).';

% vertices
X = (R + r *cos(phi) ) *cos(theta);
Y = (R + r *cos(phi) ) *sin(theta);
Z = r *sin(phi) *ones(size(theta) );

q = meshgrid2vec(X, Y, Z);
q = rot *q;
q = bsxfun(@plus, q, qc);

[X, Y, Z] = vec2meshgrid(q, X);

if nargout == 0
    surf(ax, X, Y, Z)
    clear('X')
end
