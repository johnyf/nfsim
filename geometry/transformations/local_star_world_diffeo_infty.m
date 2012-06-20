function [qmodel] = local_star_world_diffeo_infty(q, b, bi, zbase, rhoi, lambda, obstacle_index)
%LOCAL_STAR_WORLD_DIFFEO_INFTY   Local implicit star world diffeomorphism.
%
% input
%   q = point to transform
%     = [#dim x #points]
%   b = \beta(q), combined obstacle function values
%     = [1 x #points]
%   bi = \beta_i(q), individual obstacle function values
%      = [#obstacles x #points]
%   zbase = model sphere periphery
%         = [#dim x #obtsacles]
%   rhoi = radii from zbase "outward"
%        = [1 x #obstacles]
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
%
% File:      star_world_transformation.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.02.21 - 2012.05.21
% Language:  MATLAB R2012a
% Purpose:   Star world to sphere world transformation
% Copyright: Ioannis Filippidis, 2012-

% depends
%   star_deforming_factor, analytic_switch

gd = 1; % for now

%M = size(qi, 2); % # obstacles
[ndim, npnt] = size(q);

% for each obstacle, all points at once...
qmodel = zeros(ndim, npnt);
for i=obstacle_index
    %curqi = qi(:, i);
    %currhoi = rhoi(1, i);
    currhoi = rhoi(i, :);
    curbi = bi(i, :);
    
    q_qi = zbase -q(3, :);   %bsxfun(@minus, q, curqi);
    ni = variable_star_deforming_factor(q_qi, curbi, zbase, currhoi);
    si = analytic_switch(b, curbi, gd, lambda);
    
    v = bsxfun(@times, q_qi, ni);
    v = bsxfun(@times, v, si) +bsxfun(@times, q_qi, 1-si);
    %v = bsxfun(@plus, v, curqi);
    v = zbase -v;
    
    qmodel(1:2, :) = q(1:2, :);
    qmodel(3, :) = v;
end

function [ni] = variable_star_deforming_factor(q_qi, bi, zbase, rhoi)
r = abs(q_qi);
ni = rhoi .*(1 +bi) ./r;
