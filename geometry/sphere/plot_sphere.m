function [] = plot_sphere(ax, qc, r, varargin)
%PLOT_SPHERE   Plot sphere or circle (depends on dim).
%
% usage
%   plot_sphere(ax, qc, r, varargin)
%
% input
%   ax = axes object handle
%   qc = sphere center point vector
%      = [2 x 1]
%   r = sphere radius
%   varargin = args passed to plot_circle or plotSphere
%
% Date:   2012.01.30
% Author: Ioannis Filippidis, Copyright 2012-

ndim = size(qc, 1);
if ndim == 2
    plot_circle(ax, qc, r, varargin{:} )
elseif ndim == 3
    plotSphere(ax, qc, r, varargin{:} )
else
    error('N-Sphere with N>=3 cannot be plotted.')
end
