function [ellipsoids] = create_ellipsoids(qc, rot, r, pred)
%CREATE_ELLIPSOIDS    create array of quadric structures
%
% usage
%   ellipsoids = CREATE_ELLIPSOIDS(qc, rot, r)
%   ellipsoids = CREATE_ELLIPSOIDS(qc, rot, r, pred)
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
%   pred = names of predicates
%        = {1 x #ellipsoids}
%
% output
%   quadrics = structure array of ellipsoids
%            = [#ellipsoids x 1]
%       with fields:
%           quadrics(i, 1).qc = center
%           quadrics(i, 1).rot = rotation matrix
%           quadrics(i, 1).A = definition matrix
%
% See also CREATE_ELLIPSOID, ADD_QUADRIC, CREATE_TORI.
%
% File:      create_ellipsoids.m
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

if nargin < 4
    pred = repmat({''}, 1, nobs);
end

%ellipsoids = [];
for i=1:nobs
    curqc = qc(:, i);
    currot = rot{1, i};
    curr = r{1, i};
    curpred = pred{1, i};
    
    ellipsoids(i, 1) = create_ellipsoid(curqc, currot, curr, curpred);
end
