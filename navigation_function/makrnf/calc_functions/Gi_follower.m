function [Gi] = Gi_follower(qi, q, r, Ni, ds, lambda, h)
% inputs
%   qi = current agent configuration
%      = [#dim x 1]
%
%   q = other agents' configuration
%     = [#dim x (#other_agents) ]
%
%   r = increased radii of other agents
%     = [1 x (#other_agents) ]
%
%   ds = sensing/communication distance of this agent
%      > 0
%
% output
%   Gi = function G_i for agent qi
%      = [1 x 1]
%
% See also GI.
%
% File:      Gi_follower.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.09.02
% Language:  MATLAB R2011a
% Purpose:   Multi-Agent Koditschek-Rimon Navigation Function for Spherical
%            agents Decentralized under Connectivity Constraints
%            (aka MAKRNFSDC) obstacle function G_i for 1 agent
% Copyright: Ioannis Filippidis, 2011-

if ds <= 0
    error(['Nonpositive sensing/communication distance dc provided, '...
           'should be positive.'] )
end

%dm = sqrt((ds.^2 +r.^2) /2); % near/far change radius
dm = (ds +r) /2;

if ~isempty(find(dm <= r, 1) )
    error('Sensing/communication radius dc <= (ri +rj) for some agents.')
end

n = size(q, 2); % number of OTHER AGENTS

%% distances of agents
qi_q = bsxfun(@minus, qi, q);
d = vnorm(qi_q, [], 2);

b = nan(1, n);

vn = find(d <= dm); % visible AND near
vf = find( and(dm < d, d <= ds) ); % visible AND far

vfc = intersect(vf, find(Ni == 1) ); % visible AND far AND connected
vfnc = setdiff(vf, vfc); % visible AND far, but NOT connected

nv = find(ds < d); % not visible

% collision avoidance
% (near, irrespective of connection or not and far when not connected)
b(vn) = (d(vn).^2 -r(vn).^2) ./(dm(vn).^2 -r(vn).^2);
b(vfnc) = (d(vfnc).^2 -r(vfnc).^2) ./(ds^2 -r(vfnc).^2);

% connectivity (far and connected)
b(vfc) = (ds^2 -d(vfc).^2) ./(ds^2 -dm(vfc).^2); % concave function
%b(vfc) = (ds -d(vfc) ).^2 ./(ds -dm(vfc) ).^2; % convex function

% limited sensing (not visible, hence also not connected)
%b(nv) = ds^2 -r(nv).^2; % not normalized
b(nv) = ones(size(nv) );

Gi = prod(b);

%Gi = calc_Gi(b, lambda, h);
