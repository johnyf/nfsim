function [Gi] = Gi(qi, q, r, dc, lambda, h)
% qi = current agent configuration [#dim x 1]
% q = other agents' configuration [#dim x #agents]
% r = increased radii of other agents [1 x #agents]
% dc = sensing/communication distance of this agent > 0

if dc <= 0
    error(['Nonpositive sensing/communication distance dc provided, '...
           'should be positive.'] )
end

if ~isempty(find(dc <= r, 1) )
    error('Sensing/communication radius dc <= (ri +rj) for some agents.')
end

n = size(q, 2); % number of OTHER AGENTS

%% distances of agents
qi_q = bsxfun(@minus, qi, q);
d = vnorm(qi_q, [], 2);

b = nan(1, n);

v = find(d <= dc); % visible
nv = setdiff(1:n, v); % not visible

%b(v) = d(v).^2 -r(v).^2;
%b(nv) = dc^2 -r(nv).^2; % limited sensing

b(v) = (d(v).^2 -r(v).^2) ./(dc^2 -r(v).^2);
b(nv) = ones(size(nv) ); % limited sensing

Gi = calc_Gi(b, lambda, h);
