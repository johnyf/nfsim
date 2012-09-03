function [nf] = makrnfsdc(q, r, i, qdi, Ni, dsi, k, lambda, h)
% inputs
%   q = configurations of ALL agents
%     = [#dim x #agents]
%
%   r = sphere radii of all agents
%     = [1 x #agents]
%
%   i = index of current agent \in\naturals
%
%   qdi = destination configuration of agent i
%       = [] | (if absent, then agent i is a follower)
%       = [#dim x 1] (if present, then agent i is a leader)
%
%   Ni = indices of agents i should maintain connectivity
%      = [1 x #(connected_agents) ]
%
%   dsi = sensing/communication radius of current agent
%       > max(sum(ri +rj) ) >0
%
%   k, lambda, h = Multi-Agent NF parameters
%                  k >= 2, lambda > 0, h > 0
%
% output
%   nf = MAKRNFSDC field function value for agent i
%        at configuration q(:, i)
%      = [1 x 1]
%
% See also NUMGRAD_MAKRNFSDC, MAKRNFSD.
%
% File:      makrnfsdc.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.09.20 -
% Language:  MATLAB R2011a
% Purpose:   Multi-Agent Koditschek-Rimon Navigation Function for
%            Spherical agents Decentralized under Connectivity Maintenance
%            Constraints (aka MAKRNFSDC) field function
% Copyright: Ioannis Filippidis, 2011-

%% input
check_krnfd_parameters(k, lambda, h)

% current agent
qi = q(:, i); % configuration
ri = r(1, i); % radius

% other agents
q(:, i) = [];
r(:, i) = [];
r = r +ri; % Minkowski sum

% no neighbors
anyconnections = find(Ni == 1, 1);
if isempty(anyconnections)
    if dsi <= 0
        error(['Nonpositive sensing/communication distance dc provided, '...
               'should be positive.'] )
    end

    dm = sqrt((dsi.^2 +r.^2) /2); % near/far change radius

    if ~isempty(find(dm <= r, 1) )
        error('Sensing/communication radius dc <= (ri +rj) for some agents.')
    end
    
    nf = 0;
    return
end

% fix indexing of connected neighbors
Ni(:, i) = [];

%% calculate
G = Gi_follower(qi, q, r, Ni, dsi, lambda, h);

% follower or leader with connectivity?
if isempty(qdi)
    gi = follower_gd(qi, q, Ni);
else
    gi = gamma_d(qi, qdi);
end

nf = gi /(gi^k +G)^(1/k);

function [gi] = follower_gd(qi, q, Ni)
%qconnect = q(:, Ni == 1); % configurations of agents with which to maintain
%                     % connectivity

%[gd, ~] = gamma_d(qconnect, qi); % self-distance = 0 and does not matter
%gi = 1/2 *sum(gd, 2);

gi = 1;
