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
%   npnt = number of points of surface plot
%        = #pnts /circumference | [#pnts /circumference, #pnts /height]
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

%% input
if nargin < 2
    warning('args:few', 'Cylinder center not provided, using origin.')
end

if nargin < 3
    warning('args:few', 'Cylinder radius not provided, using r=1.')
end

if nargin < 4
    h = 2*r;
end

if nargin < 5
    rot = eye(3);
end

if nargin < 6
    npnt = 31;
end

%% check input
if ~isequal(size(qc), [3, 1] )
    error('Cylinder circle center qc is not [3 x 1].')
end

if size(npnt, 2) == 2
    mpnt = npnt(1, 2); % #pnts /height
    npnt = npnt(1, 1);
else
    mpnt = 15; % default
end

r = r *ones(1, mpnt);
[X, Y, Z] = cylinder(r, npnt);
res = size(Z.');

q = meshgrid2vec(X, Y, Z);
q(3, :) = h *q(3, :); % shorten to height h

% transform & plot
q = local2global_cart(q, qc, rot);
vsurf(ax, q, 'scaled', res, varargin{:} )
