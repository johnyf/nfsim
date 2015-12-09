function [ellipsoids] = create_ellipsoids(qc, rot, r, pred)
%CREATE_ELLIPSOIDS    Initializes struct array of ellipsoids.
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
%     = [#dim x #ellipsoids]
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
% 2011.11.29 (c) Ioannis Filippidis, jfilippidis@gmail.com
%
% See also CREATE_ELLIPSOID, CREATE_TORI.

nobs = size(qc, 2);

if ~iscell(rot)
    error('R is not cell array.')
end

if size(rot, 2) ~= nobs
    error('R not equal in number with obstacles.')
end

if iscell(r)
    error('iscell(r), syntax has changed, make it [#dim x #ellipsoids].')
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
    curr = r(:, i).';
    curpred = pred{1, i};
    
    ellipsoids(i, 1) = create_ellipsoid(curqc, currot, curr, curpred);
end
