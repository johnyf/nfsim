function [si] = analytic_switch(b, bi, gd, lambda)
%ANALYTIC_SWITCH    Smooth switch from one obstacle to another.
%   si = analytic_switch(b, bi, gd, lambda) returns a switch function which
%   transitions smoothly from 1 on the boundary of other obstacles, to 0 on
%   the boundary of the current obstacle bi.
%
% usage
%   si = analytic_switch(b, bi, gd, lambda)
%
% input
%   b = product of obstacle functions
%     = [1 x #points]
%   bi = current obstacle function
%      = [1 x #points]
%   gd = destination function
%      = [1 x #points]
%   lambda = tuning parameter
%          > 0
%
% output
%   si = smooth switch function values at calculation points q
%      = [1 x #points] \in [0, 1]
%
% reference
%   Rimon-Koditschek Star Deforming Factor, p.78, TAMS
%
% See also STAR_WORLD_TRANSFORMATION.
%
% File:      analytic_switch.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.02.21 - 2012.05.24
% Language:  MATLAB R2012a
% Purpose:   Analytic switch function between obstacles
% Copyright: Ioannis Filippidis, 2012-

si = b .*gd ./(b .*gd +lambda .*bi.^2);
si(and(0 <= b, bi < 0) ) = 1;
si(and(b <= 0, 0 < bi) ) = 0;

% si = b .*gd ./(b .*gd +lambda .*bi.^2);
% si(bi < 0) = 1;
% si(si < 0) = 0;
