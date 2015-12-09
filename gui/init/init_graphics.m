function [nfgui] = init_graphics(nfgui, world, known_world, agent)
% File:      init_graphics.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2010.10.16 - 2011.08-18
% Language:  MATLAB R2011a
% Purpose:   initialize graphics (figs, axes, etc.)
% Copyright: Ioannis Filippidis, 2010-

%% get data
S = guidata(nfgui.fig);

ax1 = S.plots.h_field_ax;
ax2 = S.plots.h_map_ax;

%% main
nfgui.field_parameter = []; % to detect field change & update it

draw_world(ax2, world, known_world, agent)

uistack(ax1, 'top')
uistack(ax2, 'top')
