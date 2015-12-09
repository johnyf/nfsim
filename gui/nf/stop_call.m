function [] = stop_call(src, varargin)
%% get data
S = guidata(src);

%% main
stop_actions(S)
set(gcbo, 'userdata', 1);
