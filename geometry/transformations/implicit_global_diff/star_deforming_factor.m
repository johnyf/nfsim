function [ni] = star_deforming_factor(q, bi, qi, ri, inward)
% for star world to sphere world transformation
%
% input
%   q = points to transform
%     = [#ndim x #points]
%   bi = single obstacle function values
%      = \beta_i(q)
%      = [1 x #points]
%   qi = model sphere centers
%      = [#dim x #obstacles]
%   ri = model sphere radii
%      = [1 x #obstacles]
%   inward = flag signaling that a 0th obstacle is given
%          = 0 | 1
%
% output
%   ni = star deforming factors
%      = \nu_i(q) > 0
%
% Reference:
%   Rimon-Koditschek Star Deforming Factor, p.78, TAMS
%
% See also STAR_WORLD_TRANSFORMATION.

if nargin < 5
    inward = 1;
end

% 0th obstacle ?
if inward
    bi = -bi;
end

q_qi = bsxfun(@minus, q, qi);
r = vnorm(q_qi, 1, 2);
ni = ri .*(1 +bi) ./r;
