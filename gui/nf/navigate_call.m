function [] = navigate_call(src, varargin)
%% get data
S = guidata(src);

%% main
resume_actions(S)
evalin('base', 'navigation_main')
stop_call(src);
