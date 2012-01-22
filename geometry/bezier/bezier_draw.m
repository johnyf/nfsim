% File:         bezier_draw.m
% Author:   Ioannis Filippidis, Mechanical Engineer, jfilippidis@gmail.com
% Date:         2010.09.12
% Language:     MATLAB, program version: 7.11 (2010b)
% Purpose:      given bezier coefficients & parameter values t return
%               bezier curve points corresponding to these t values.
% Copyright:    Ioannis Filippidis, 2010-

function [xb] = bezier_draw(varargin)

% [xb] = bezier_draw(bezier_coef, xcp, t1, t2, flag, style, agent)
% [xb] = bezier_draw(ax, bezier_coef, xcp, t1, t2, flag, style, agent)

% xcp = control points
% draw_cp? 0=NO | 1=YES
% varargin = [t_min, t_max], default=[0,1]

%% varargin
if (nargin < 7) || (8 < nargin)
    error('This function takes 7 or 8 arguments.')
end

bezier_coef = varargin{nargin -6};
xcp = varargin{nargin -5};
t1 = varargin{nargin -4};
t2 = varargin{nargin -3};
flag = varargin{nargin -2};
style = varargin{nargin -1};
agent = varargin{nargin};

if nargin == 8
    ax = varargin{1};
else
    ax = gca;
end

%% calculate bezier curve points
if (t1 == t2)
    t = t1;
else
    if flag == 0
        t = linspace(t1, t2, 1000);
    else
        t_1 = linspace(0, t2, 500);
        t_2 = linspace(t1, 1, 500);
        t = [t_2, t_1];
    end
end
xb = bezier_points(bezier_coef,t);

hold(ax, 'on')

%% plot curve
switch size(xb,1)
    case 2
        plot(ax, xb(1,:), xb(2,:), 'Color', style, 'Linewidth', 1.5)
    case 3
        plot3(ax, xb(1,:), xb(2,:), xb(3,:), 'Color', style, 'Linewidth', 1.5)
    otherwise
        disp('This Bezier curve does not live in 3D!')
        return;
end

%% plot sensing rays through end-points
if ~isempty(agent)
    draw_rays(ax, xb, agent)
end

% also draw the straight line connecting this bezier segment's
% endpoints. This is the minimal real obstacle being known from that
% interval until now. The closing line belongs to the obstacle because
% of the convex obstacle's assumption.
% Note: this line may reduce to a point when drawing the complete
% obstacle
plot(ax, [xb(1,1), xb(1,end)],[xb(2,1), xb(2,end)], 'Color', 'r', 'Linewidth', 1.5, 'Linestyle', '--')

% draw control points?
if isempty(xcp)
    hold(ax, 'off')
    %disp('Control polygon not drawn.')
    return;
end

%% plot control points
switch size(xcp,1)
    case 2
        plot(ax, xcp(1,:), xcp(2,:), 'g--')
        plot(ax, xcp(1,:), xcp(2,:), 'ro')
        text(ax, xcp(1,:), xcp(2,:), num2str( (1:size(xcp,2))' ))
    case 3
        plot3(ax, xcp(1,:), xcp(2,:), xcp(3,:), 'g--')
        plot3(ax, xcp(1,:), xcp(2,:), xcp(3,:), 'ro')
    otherwise
        disp('This Bezier curve does not live in 3D!')
        return;
end

hold(ax, 'off')

% look impoly()
