function [] = plot_path(varargin)
% [] = plot_path(agent)
% [] = plot_path(ax, agent)
% [] = plot_path(agent, z)
% [] = plot_path(ax, agent, z)
% [] = plot_path(agent, z, xnf)
% [] = plot_path(ax, agent, z, xnf)
%
% ax: axes handle
% x: path subsequent points
% xnf: navigation function values at corresponding points
% z: the contour plot level
%
% File:      plot_path.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2010.09.20
% Language:  MATLAB R2010b
% Purpose:   plot path followed both in 3D (depicting it on the constant or
%             changing field) and in 2D being the gradient integral curve &
%             actual path
% Copyright: Ioannis Filippidis, 2010-

if nargin == 0
    error('No arguments provided.')
end

if ishandle(varargin{1} )
    ax = varargin{1};
    agent = varargin{2};
    n = 2;
else
    ax = gca;
    agent = varargin{1};
    n = 1;
end

if nargin > n
    zoff = varargin{n +1};
else
    zoff = 0; % contour plot plane z offset
end

n = n +1;

if nargin > n
    xnf = varargin{n +1};
else
   xnf = [];
end

x0 = agent.x0;
x = agent.x;
xcur = agent.xcur;
xd = agent.xd;

if agent.sensing == 1
    Rs = agent.Rs;
else
    Rs = [];
end

hold(ax, 'on')

ndim = size(x0, 1);

if ndim == 2
    path2D(ax, x0, x, xd, xcur, xnf, zoff, Rs);
elseif ndim == 3
    path3D(ax, x0, x, xd, xcur, Rs);
else
    error('Plot available for 2 and 3 dimensions only.')
end

hold(ax, 'off')

function [] = path2D(ax, x0, x, xd, xcur, xnf, zoff, Rs)
% 2D path @ iso-contours z level
plot3(ax, x0(1,1), x0(2,1), -zoff,...
    'Linewidth', 2, 'Color', 'm', 'Marker', 's');
if ~isempty(x)
    plot3(ax, x(1,:), x(2,:), zeros(1,length(x))-zoff,...
        'Linewidth', 2, 'Color', 'm', 'Linestyle', '-');
    plot3(ax, x(1,end), x(2,end), -zoff,...
        'Linewidth', 2, 'Color', 'm', 'Marker', 'o');
end
plot3(ax, xd(1,1), xd(2,1), -zoff,...
    'Linewidth', 2, 'Color', 'm', 'Marker', 'x');

if ~isempty(xnf)
    % 3D path (imagined on field surface)
    plot3(ax, x(1,:), x(2,:), xnf, 'Linewidth', 3, 'Color', 'm', 'Linestyle', '-');
end

%% sensing on?
if ~isempty(Rs)
    plot_circle(ax, xcur, Rs, 'r', 'Color', 'm', 'LineStyle', '--',...
        'CenterStyle', 'mo')
end

function [] = path3D(ax, x0, x, xd, xcur, Rs)
plot3(ax, x0(1,1), x0(2,1), x0(3,1),...
        'Linewidth', 2, 'Color', 'm', 'Marker', 's', 'HandleVisibility','off');
    
axold = gca;
axes(ax);

h = text(1.1 *x0(1,1), 1.1 *x0(2,1), 1.1 *x0(3,1), '$x(0)$');
set(h, 'Interpreter', 'Latex')

h = text(1.1 *xd(1,1), 1.1 *xd(2,1), 1.1 *xd(3,1), '$q_d$');
set(h, 'Interpreter', 'Latex')

axes(axold);
    
if ~isempty(x)
    plot3(ax, x(1,:), x(2,:), x(3,:),...
        'Linewidth', 2, 'Color', 'm', 'Linestyle', '-');
    plot3(ax, x(1,end), x(2,end), x(3,end),...
        'Linewidth', 2, 'Color', 'm', 'Marker', 'o', 'HandleVisibility','off');
end
plot3(ax, xd(1,1), xd(2,1), xd(3,1),...
    'Linewidth', 2, 'Color', 'm', 'Marker', 'x', 'HandleVisibility','off');

%% sensing on?
if ~isempty(Rs)
    plotSphere(ax, xcur, Rs, 'Color', 'r', 'Opacity', 0);
end
