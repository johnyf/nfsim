function [qmodel] = star_world_transformation(q, b, bi, qi, ri, inward, lambda)
%
% input
%   q = point to transform
%     = [#dim x #points]
%   b = \beta(q), combined obstacle function values
%     = [1 x #points]
%   bi = \beta_i(q), individual obstacle function values
%      = [#obstacles x #points]
%   qi = model sphere centers
%      = [#dim x #obtsacles]
%   ri = model sphere radii
%      = [1 x #obstacles]
%   lambda = star world transformation parameter
%          > 0
%
% output
%   qmodel = transformed points
%
% Note
%   b independently provided from bi, to allow any combination (product,
%   Rvachev, fading composed with these, etc.) to be used
%
% Reference
%   Rimon-Koditschek Star Deforming Factor, p.79, TAMS
%
% See also STAR_DEFORMING_FACTOR, ANALYTIC_SWITCH.

gd = 1; % for now

M = size(qi, 2); % # obstacles
[ndim, npnt] = size(q);

% for each obstacle, all points at once...
qmodel = zeros(ndim, npnt);
for i=1:M
    curqi = qi(:, i);
    curri = ri(1, i);
    curbi = bi(i, :);
    curinward = inward(i, 1);
    
    q_qi = bsxfun(@minus, q, curqi);
    ni = star_deforming_factor(q, curbi, curqi, curri, curinward);
    si = analytic_switch(b, curbi, gd, lambda);
    
    v = bsxfun(@times, q_qi, ni);
    v = bsxfun(@plus, v, curqi);
    v = bsxfun(@times, v, si);
    
    qmodel = qmodel +v;
end
