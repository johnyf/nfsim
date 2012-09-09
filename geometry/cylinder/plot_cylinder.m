function [] = plot_cylinder(ax, qc, r, h, rot, npnt, varargin)
%PLOT_CYLINDER  Plot a cylinder.
%
% input
%   ax = axis object handle
%   qc = center of circle at one end of the cylinder
%      = [3 x 1]
%   r = cylinder radius
%     > 0
%   h = cylinder height
%     > 0
%   rot = rotation matrix around point qc
%       = [3 x 3] \in SO(3)
%   npnt = number of points around circumference for surface plot
%   varargin = additional arguments for function surf.
%
% See also PLOT_CYLINDERS, BETA_CYLINDER, CREATE_CYLINDER.
%
% File:      plot_cylinder.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.01.02
% Language:  MATLAB R2012a
% Purpose:   plot cylinders
% Copyright: Ioannis Filippidis, 2012-

% check input
if ~isequal(size(qc), [3, 1] )
    error('Cylinder circle center qc is not [3 x 1].')
end

[X, Y, Z] = cylinder(r, npnt);
res = size(Z.');

q = meshgrid2vec(X, Y, Z);
q(3, :) = h *q(3, :); % shorten to height h

% transform & plot
q = local2global_cart(q, qc, rot);
vsurf(ax, q, 'scaled', res, varargin{:} )
