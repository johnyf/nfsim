function [not_ellispoids] = create_not_ellipsoids(qc, rot, r, pred)
%CREATE_NOT_ELLIPSOIDS    create array of inward quadric structures.
%   Same as create_ellipsoids.
%
% usage
%   not_ellispoids = CREATE_NOT_ELLIPSOIDS(qc, rot, r, pred)
%
% input
%   See create_ellipsoids.
%
% See also create_not_ellipsoid, beta_not_ellipsoids, plot_not_ellipsoids.
%
% File:      create_not_ellipsoids.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.01.30
% Language:  MATLAB R2011b
% Purpose:   initializes structure array of inward ellipsoids
% Copyright: Ioannis Filippidis, 2011-

% note
%   although logical negation can yield this, a special obstacle type can
%   accelerate execution

if nargin < 4
    not_ellispoids = create_ellipsoids(qc, rot, r);
else
    not_ellispoids = create_ellipsoids(qc, rot, r, pred);
end