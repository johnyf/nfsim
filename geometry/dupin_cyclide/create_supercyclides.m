function [cyclides] = create_supercyclides(qc, R, rm, dr, rot, q0, pred)
%CREATE_ELLIPSOIDS    Initializes struct array of ellipsoids.
%
% usage
%   supercyclides = CREATE_SUPERCYCLIDES(qc, rot, r)
%   supercyclides = CREATE_SUPERCYCLIDES(qc, rot, r, pred)
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

if nargin < 7
    pred = repmat({''}, 1, nobs);
end

%ellipsoids = [];
for i=1:nobs
    curqc = qc(:, i);
    curR = R(1, i);
    currm = rm(1, i);
    curdr = dr(1, i);
    currot = rot{1, i};
    curq0 = q0(:, i);
    curpred = pred{1, i};
    
    cyclides(i, 1) = create_supercyclide(curqc, curR, currm,...
                                           curdr, currot,  curq0, curpred);
end
