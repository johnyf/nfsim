function [nf] = makrfsd(q, r, i, qdi, dci, k, lambda, h)
% Decentralized multi-agent Koditschek-Rimon function for spherical agents
%
% inputs
%   q = configurations of ALL agents
%     = [#dim x #agents]
%
%   r = sphere radii of all agents
%     = [1 x #agents]
%
%   i = index of current agent \in[1,2,...,#agents]
%
%   qdi = destination configuration of agent i
%       = [#dim x 1]
%
%   dci = sensing/collision avoidance effect radius of current agent
%       > max(sum(ri +rj) ) >0
%
%   k, lambda, h = Multi-Agent NF parameters
%                  k >= 2, lambda > 0, h > 0
%
% output
%   nf = MAKRFSD field function value for agent i
%        at configuration q(:, i)
%      = [1 x 1]
%
% 2011.09.02 - 2011.09.20 (c) Ioannis Filippidis, jfilippidis@gmail.com
%
% See also NUMGRAD_MAKRFSD, MAKRFSDC.

%% input
check_krfd_parameters(k, lambda, h)

% current agent
qi = q(:, i); % configuration
ri = r(1, i); % radius

% other agents
q(:, i) = [];
r(:, i) = [];
r = r +ri; % Minkowski sum

%% calculate
G = Gi(qi, q, r, dci, lambda, h);
[gdi, ~] = gamma_d(qi, qdi);

nf = gdi /(gdi^k +G)^(1/k);

nf( (G < 0) || (~isreal(G) ) ) = 1;
