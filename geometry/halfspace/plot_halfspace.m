function [varargout] = plot_halfspace(ax, xp, n, npnt, domain, varargin)
%PLOT_HALFSPACE     Halfspace plot.
%
%
% See also PLOT_HALFSPACES, BETA_HALFSPACE.
%
% File:      plot_halfspace.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.12.25 - 
% Language:  MATLAB R2011b
% Purpose:   plot an half-space
% Copyright: Ioannis Filippidis, 2011-

% todo: implement 2D half-plane plotting

ndim = size(xp, 1);

%% check args
if isempty(ax)
    ax = gca;
end

if nargin < 4
    npnt = [10, 9];
else
    npnt = [npnt, npnt -1];
end

if nargin < 5
    domain = [-1, 1, -1, 1];
end

%% calculations


%% graphics calculation

% % 2D case
% if ndim == 2
%     [x, y] = drawEllipse(0, 0, D(1,1), D(2,2) ); % David Legland's
%     
%     XY = R *V *[x; y];
%     XY = bsxfun(@plus, XY, xc);
% end

% 3D case

A = zeros(3);
A(1, :) = n.';
B = null(A);
n1 = B(:, 1);
n2 = B(:, 2);

sx = linspace(domain(1, 1), domain(1, 2), npnt(1, 1) );
sy = linspace(domain(1, 3), domain(1, 4), npnt(1, 2) );
if ndim == 3
    for i=1:npnt(1, 1)
        for j=1:npnt(1, 2)
            X = sx(1, i) *n1 +sy(1, j) *n2 +xp;
            x(j, i) = X(1, 1);
            y(j, i) = X(2, 1);
            z(j, i) = X(3, 1);
        end
    end
end

%% only output wanted?
if nargout > 0
    % 2D case
    varargout{1} = XY;

    if ndim == 3
        varargout{1} = XYZ;
    end
    return
end

%% plot
if ndim == 2
    %plot(ax, XY(1,:), XY(2,:) )
elseif ndim == 3
    surf(ax, x, y, z, varargin{:} )
else
    error('ndim ~= 2, 3.')
end
