function [quadric] = create_ellipsoid(qc, rot, r)
%CREATE_ELLIPSOID   initialize ellipsoid structure
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
%   quadric = structure of quadric parameters
%
% See also create_quadrics, create_torus, create_quadric_inward.
%
% File:      create_ellipsoid.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.11.29 - 
% Language:  MATLAB R2011b
% Purpose:   initializes an ellipsoid, given its geometric parameters
% Copyright: Ioannis Filippidis, 2011-

quadric.qc = qc;
quadric.A = radii2ellipsoid(r);
quadric.rot = rot;
