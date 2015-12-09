function [xb] = bezier_draw(ax, bezier_coef, xcp, t1, t2, flag, style, xcur)
%
% usage
%   [xb] = bezier_draw(ax, bezier_coef, xcp, t1, t2, flag, style, agent)
%
% input
%   xcp = control points
%   draw_cp? 0=NO | 1=YES
%   varargin = [t_min, t_max], default=[0,1]
%
% File:      bezier_draw.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2010.09.12
% Language:  MATLAB R2011b
% Purpose:   given bezier coefficients & parameter values t return
%            bezier curve points corresponding to these t values.
% Copyright: Ioannis Filippidis, 2010-

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
xb = bezier_points(bezier_coef, t);

held = applyhold(ax);

%% plot curve
plotmd(ax, xb, 'Color', style, 'Linewidth', 1.5)

%% plot sensing rays through end-points
if ~isempty(xcur)
    draw_rays(ax, xcur, xb)
end

% also draw the straight line connecting this bezier segment's
% endpoints. This is the minimal real obstacle being known from that
% interval until now. The closing line belongs to the obstacle because
% of the convex obstacle's assumption.
% Note: this line may reduce to a point when drawing the complete
% obstacle
plotmd(ax, xb(:, [1, end] ), 'Color', 'r', 'Linewidth', 1.5, 'Linestyle', '--')

% draw control points?
if isempty(xcp)
    hold(ax, 'off')
    %disp('Control polygon not drawn.')
    return;
end

%% plot control points
plotmd(ax, xcp, 'g--')
plotmd(ax, xcp, 'ro')
textmd(ax, xcp, num2str((1:size(xcp, 2) )' ) )

holdback(ax, held)
