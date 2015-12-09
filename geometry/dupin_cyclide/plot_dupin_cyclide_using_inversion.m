function [] = plot_dupin_cyclide_using_inversion(ax, qc, r, q0, r0, varargin)
%PLOT_DUPIN_CYCLIDE_USING_INVERSION     Plot Dupin cyclide.
%   PLOT_DUPIN_CYCLIDE_USING_INVERSION(ax, qc, r, q0, r0) plots a Dupin
%   cyclide using geometric inversion with respect to an inversion sphere
%   of radius r0, centered at q0. The basis torus has center qc,
%   major diameter r and minor diameter 1.
%
% usage
%   PLOT_DUPIN_CYCLIDE_USING_INVERSION(ax, qc, r, q0, r0, varargin)
%
% input
%   ax = axes object handle
%   qc = center of torus
%      = [3 x 1]
%   r = major torus radius
%     > 0
%   q0 = center of sphere used for geometric inversion
%      = [3 x 1] = [x0, y0, z0].';
%   r0 = radius of sphere used for geometric inversion
%      > 0
%   varargin = options passed to surf
%
% Like the obstacle function (beta_dupin_cyclide), this function also
% has two alternative definitions, either via the inversion of a torus
% or the direct parameterization using the parameters a, c, \mu.
%
% See also PLOT_ELLIPTIC_SUPERCYCLIDE, BETA_SUPERCYCLIDE,
%          EXAMPLE_DUPIN_CYCLIDE, example_supercyclide.
%
% File:      plot_dupin_cyclide_using_inversion.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.02.19 - 2012.05.19
% Language:  MATLAB R2012a
% Purpose:   Plot a Dupin cyclide defined as the inversion of a torus
% Copyright: Ioannis Filippidis, 2012-

domain = [-pi, pi, -pi, pi];
resolution = [35, 100];

[uv, U, ~] = domain2vec(domain, resolution);

u = uv(1, :);
v = uv(2, :);

q_torus = [ (r +cos(u) ) .*cos(v);...
            (r +cos(u) ) .*sin(v);...
                sin(u) ];
            
q_torus = bsxfun(@plus, q_torus, qc);

q_dupin = geometric_inversion(q_torus, q0, r0);

[X, Y, Z] = vec2meshgrid(q_dupin, U);

surf(ax, X, Y, Z, varargin{:} )
