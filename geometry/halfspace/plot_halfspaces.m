function [] = plot_halfspaces(ax, halfspaces, npnt, varargin)
%PLOT_HALFSPACES    Plot multiple hyperplanes.
%
%usage
%-----
%   PLOT_HALFSPACES(ax, halfspaces, npnt, varargin)
%
%input
%-----
%   ax = axes object handle
%   halfspaces = struct array of halfspaces returned by create_halfspaces
%              = [#halfspaces x 1]
%   npnt = #points /side
%   varargin = directly passed to plotmd, surf, see plot_halfspace
%
%about
%-----
%2011.12.25 (c) Ioannis Filippidis, jfilippidis@gmail.com
%
%See also plot_halfspace, beta_halfspaces, create_halfspaces.

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
    
    plot_halfspace(ax, qp, n, npnt, domain, varargin{:} )
end
restorehold(ax, held)
