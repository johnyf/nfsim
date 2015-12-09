function [] = slider_k_callback(src, varargin)
%% get data
S = guidata(src);

fig = S.fig(1);

%% main
slider_k_call(fig);
