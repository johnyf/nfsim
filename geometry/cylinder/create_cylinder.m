function [cylinder] = create_cylinder(qc, r, h, axisv, pred)
%CREATE_CYLINDER    Initialize cylinder struct.
%
% usage
%   cylinder = CREATE_CYLINDER(qc, r, h, axisv)
%   cylinder = CREATE_CYLINDER(qc, r, h, axisv, pred)
%
% input
%   qc = center of circle at one end of the cylinder
%      = [3 x 1]
%   r = cylinder radius
%     > 0
%   h = cylinder height
%     > 0
%   axisv = vector of cylinder axis of rotation
%       = [#dim x 1]
%
% output
%   cylinder = struct with fields qc, r, h, rot
%
% See also create_cylinders, add_cylinder, beta_cylinder, plot_cylinder.
%
% File:      create_cylinder.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.09.01
% Language:  MATLAB R2012a
% Purpose:   initialize cylinder object, given its parameters
% Copyright: Ioannis Filippidis, 2012-

if norm(axisv) == 0
    error('Axis vector is zero.')
end

if nargin < 5
    pred = '';
end

zaxis = [0, 0, 1].';
rotvec = cross(zaxis, axisv);

costheta = dot(zaxis, axisv) /vnorm(axisv, 1, 2);
theta = acos(costheta);
rot = angvec2r(theta, rotvec);

cylinder = struct('qc', qc, 'r', r, 'h', h, 'rot', rot, 'predicate', pred);
