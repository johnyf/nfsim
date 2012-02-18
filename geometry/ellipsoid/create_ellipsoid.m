function [quadric] = create_ellipsoid(qc, rot, r)
%CREATE_ELLIPSOID   initialize ellipsoid structure
%
% usage
%   quadric = CREATE_ELLIPSOID(qc, rot, r)
%
% inputs
%   qc = ellipsoid center
%      = [#dim x 1]
%   rot = ellipsoid axis rotation matrix
%       = [#dim x #dim]
%   r = ellipsoid radii
%     = [1 x #dim]
%
% output
%   quadric = structure of quadric parameters, with fields:
%       quadric.qc = center
%       quadric.rot = rotation matrix
%       quadric.A = ellipsoid definition matrix
%
% See also CREATE_QUADRICS, CREATE_TORUS, CREATE_QUADRIC_INWARD.
%
% File:      create_ellipsoid.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.11.29 - 
% Language:  MATLAB R2011b
% Purpose:   initializes an ellipsoid, given its geometric parameters
% Copyright: Ioannis Filippidis, 2011-

quadric.qc = qc;
quadric.rot = rot;
quadric.A = radii2ellipsoid(r);
