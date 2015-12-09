function [ni] = star_deforming_factor(q, bi, qi, ri, inward)
%STAR_DEFORMING_FACTOR  Deformation scaling factor along ray.
%
% usage
%   ni = star_deforming_factor(q, bi, qi, ri, inward)
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
%      = [1 x #points]
%
% reference
%   Rimon-Koditschek Star Deforming Factor, p.78, TAMS
%
% See also STAR_WORLD_TRANSFORMATION.
%
% File:      star_deforming_factor.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.02.21 - 2012.05.24
% Language:  MATLAB R2012a
% Purpose:   Star deformation ratio along radius
% Copyright: Ioannis Filippidis, 2012-

% depends
%   vnorm

bi(inward == 1, :) = -bi(inward == 1, :);

q_qi = bsxfun(@minus, q, qi);
r = vnorm(q_qi, 1, 2);
ni = ri .*(1 +bi) ./r;
