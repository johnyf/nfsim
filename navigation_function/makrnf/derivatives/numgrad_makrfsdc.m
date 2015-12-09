function [grad] = numgrad_makrfsdc(q, r, curi, qdi, Ni, dsi,...
    k, lambda, h, dh)
% MAKRFSDC numerical gradient for 1 agent
%
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
%   dh = numerical gradient perturbation scalar
%      > 0 (and sufficiently small for robust numerical results)
%
% output
%   grad = agent numerical gradient
%        = [#dim x 1]
%
% 2011.09.20 (c) Ioannis Filippidis, jfilippidis@gmail.com
%
% See also MAKRFSDC, NUMGRAD_MAKRFSD.

qi = q(:, curi);
pt = numgradpt(qi, dh);

n = size(pt, 2);

f = nan(1, n);
for j=1:n
    q(:, curi) = pt(:, j);
    f(1, j) = makrfsdc(q, r, curi, qdi, Ni, dsi, k, lambda, h);
end

grad = numgrad(f, dh);
