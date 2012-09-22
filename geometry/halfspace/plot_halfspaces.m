function [] = plot_halfspaces(ax, halfspaces, npnt)
%PLOT_HALFSPACES    Plot multiple hyperplanes.
%
% usage
%   PLOT_HALFSPACES(ax, halfspaces, npnt)
%
% input
%   ax = axes object handle
%   halfspaces = struct array of halfspaces returned by create_halfspaces
%              = [#halfspaces x 1]
%   npnt = #points /side
%
% See also plot_halfspace, beta_halfspaces, create_halfspaces.
%
% File:      plot_halfspaces.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.12.25
% Language:  MATLAB R2011b
% Purpose:   plot multiple half-spaces
% Copyright: Ioannis Filippidis, 2011-

%% input
if isempty(ax)
    ax = gca;
end

if nargin < 3
    npnt = 4;
end

%% plot
nhalfspaces = size(halfspaces, 1);

held = takehold(ax, 'local');
for i=1:nhalfspaces
    qp = halfspaces(i, 1).qp;
    n = halfspaces(i, 1).n;
    domain = halfspaces(i, 1).domain;
    
    plot_halfspace(ax, qp, n, npnt, domain)
end
restorehold(ax, held)
