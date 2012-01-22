function [nfgui] = creategraphics()
% File:      creategraphics.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2010.10.24 - 2011.08.17
% Language:  MATLAB R2011a
% Purpose:   create main gui for navigation function simulation (2D or 3D)
% Copyright: Ioannis Filippidis, 2010-

welcome_msg
S = initgui;
S = init_application_data(S);
nfgui.fig = S.fig(1);

%% problem data structures
% S.agent

% S.world

% S.known_world

% S.sensed_world

%% application current settings
% S.selected_field
%   =selected potential fields method
%   used in NAV_SELECT_NF_CALL

% S.field_resolution
%   =selected grid point number in field plot

% S.stop_circle_draw

%% graphics objects
% S.fig
%   =handle of nfsim figure window
%   used everywhere
%   set by initgui

% S.menus
%   =handles to menu objects
%   set by initgui

% S.panels
%   =handles to panel objects
%   set by initgui

% S.plots
%   =handles to plot axes objects
%   set by initgui

% S.h_zoom_all
%   set by initgui

% S.h_draw_circle
%   set by initgui
