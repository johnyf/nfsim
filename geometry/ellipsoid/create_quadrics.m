function [quadrics] = create_quadrics(qc, rot, r)
%CREATE_QUADRICS    create array of quadric structures
%
% usage
%   quadrics = CREATE_QUADRICS(qc, rot, r)
%
% input
%   qc = ellipsoid centers
%      = [#dim x #ellipsoids]
%   rot = rotation matrices
%       = {1 x #ellipsoids}
%       = {[#dim x #dim], ... }
%   r = radii matrices
%     = {1 x #ellipsoids}
%     = {[1 x #dim], ... }
%
% output
%   quadrics = structure array of ellipsoids
%            = [1 x #ellipsoids]
%       with fields:
%           quadrics(1, i).qc = center
%           quadrics(1, i).rot = rotation matrix
%           quadrics(1, i).A = definition matrix
%
% See also CREATE_ELLIPSOID, ADD_QUADRIC, CREATE_TORI.
%
% File:      create_quadrics.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.11.29 - 
% Language:  MATLAB R2011b
% Purpose:   initializes structure array of ellipsoids
% Copyright: Ioannis Filippidis, 2011-

nobs = size(qc, 2);

if ~iscell(rot)
    error('R is not cell array.')
end

if size(rot, 2) ~= nobs
    error('R not equal in number with obstacles.')
end

if ~iscell(r)
    error('r is not cell array.')
end

if size(r, 2) ~= nobs
    error('r not equal in number with obstacles.')
end

quadrics = [];
for i=1:nobs
    curqc = qc(:, i);
    currot = rot{1, i};
    curr = r{1, i};
    
    quadric = create_ellipsoid(curqc, currot, curr);
    
    quadrics = add_quadric(quadric, quadrics);
end
