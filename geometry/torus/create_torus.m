function [torus] = create_torus(qc, r, R, rot)
%CREATE_TORUS   initialize 2-torus structure
%
% inputs
%   qc = torus center
%      = [#dim x 1]
%   r = torus tube radius
%     > 0
%   R = torus radius
%     > 0
%   rot = torus axis rotation matrix
%       = [#dim x #dim]
%
% output
%   torus = structure of torus parameters
%
% See also create_quadric, create_quadrics, create_quadric_inward.
%
% File:      create_torus.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.12.24 - 
% Language:  MATLAB R2011b
% Purpose:   initializes a torus, given its geometric parameters
% Copyright: Ioannis Filippidis, 2011-

torus.qc = qc;
torus.r = r;
torus.R = R;
torus.rot = rot;

