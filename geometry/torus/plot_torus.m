function [h] = plot_torus(ax, qc, r, R, rot, npnt, varargin)
%PLOT_TORUS  Plot a torus.
%
% usage
%   H = PLOT_TORUS(ax, qc, r, R, rot, npnt, varargin)
%
% input
%   ax = axes object handle
%   qc = torus center
%      = [3 x 1]
%   r = torus minor radius (lateral radius)
%     > 0
%   R = torus major radius (central radius)
%     > 0
%   rot = rotation matrix
%       \in SO(3)
%   npnt = number of points for the parametric surface
%   varargin = additional arguments for function surf
%
% See also plot_tori, beta_torus, create_torus, parametric_torus.
%
% File:      plot_torus.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2010.12.05 - 2012.09.02
% Language:  MATLAB R2012a
% Purpose:   plot a torus
% Copyright: Ioannis Filippidis, 2010-

[q, res] = parametric_torus(qc, r, R, rot, npnt);
h = vsurf(ax, q, 'scaled', res, varargin{:} )
