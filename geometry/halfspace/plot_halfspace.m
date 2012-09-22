function [] = plot_halfspace(ax, xp, n, npnt, domain, varargin)
%PLOT_HALFSPACE     Plot hyperplane (finite rectangular region).
%
% usage
%   PLOT_HALFSPACE(ax, xp, n, npnt, domain, varargin)
%
% input
%   ax = axes object handle
%   xp = point in half-space boundary (=hyperplane)
%      = [#dim x 1]
%   n = normal vector to half-space oriented towards its interior
%     = [#dim x 1]
%   npnt = #points /side
%   domain = rectangular limits within hyperplane boundary which define
%            the region to plot
%          = [xmin, xmax] | %(for 2D)
%          = [ximn, xmax, ymin, ymax] %(for 3D)
%   varargin = additional arguments passed to surf
%
% See also plot_halfspaces, beta_halfspace, create_halfspace.
%
% File:      plot_halfspace.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.12.25 - 
% Language:  MATLAB R2011b
% Purpose:   plot a half-space
% Copyright: Ioannis Filippidis, 2011-

% todo: implement 2D half-plane plotting

ndim = size(xp, 1);

%% check args
if isempty(ax)
    ax = gca;
end

if nargin < 4
    if ndim == 2
        res = [10];
    elseif ndim == 3
        res = [10, 9];
    end
else
    if ndim == 2
        res = [npnt];
    elseif ndim == 3
        res = [npnt, npnt+1];
    end
end

if nargin < 5
    domain = [-1, 1, -1, 1];
end

if ndim == 2
    res = res(1, 1);
    domain = domain(1, 1:2);
end

%% calc & plot
switch ndim
    case 2
        q = calc_line_region(xp, n, domain, res);
        plotmd(ax, q, varargin{:} )
    case 3
        q = calc_plane_region(xp, n, domain, res);
        vsurf(ax, q, 'scaled', res, varargin{:} )
    otherwise
        error(['Dimension of xp is ', num2str(ndim) ] )
end

function [q] = calc_line_region(xp, n, domain, res)
ndim = size(n, 1);
A = zeros(ndim);
A(1, :) = n.';
B = null(A);
n1 = B(:, 1);

% right-handed
if det([n, n1] ) < 0
    n1 = -n1;
end

sx = linspace(domain(1, 1), domain(1, 2), res);
q = bsxfun(@plus, n1 *sx, xp);

function [q] = calc_plane_region(xp, n, domain, res)
ndim = size(n, 1);
A = zeros(ndim);
A(1, :) = n.';
B = null(A);
n1 = B(:, 1);
n2 = B(:, 2);

% right-handed
if det([n, n1, n2] ) < 0
    n2 = -n2;
end

sx = linspace(domain(1, 1), domain(1, 2), res(1, 1) );
sy = linspace(domain(1, 3), domain(1, 4), res(1, 2) );

q1 = n1 *sx;
q2 = n2 *sy;

npnt = prod(res);
q = nan(ndim, npnt);
k = 1;
for i=1:res(1, 1)
    for j=1:res(1, 2)
        q(:, k) = q1(:, i) +q2(:, j) +xp;
        k = k +1;
    end
end
