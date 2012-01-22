function [fig, h_zoom_all, h_draw_circle,...
    h_map_ax, h_field_ax] = getgui_objhandles(S)

fig = S.fig(1);

h_map_ax = S.plots.h_map_ax;
h_field_ax = S.plots.h_field_ax;

h_zoom_all = S.h_zoom_all;
h_draw_circle = S.h_draw_circle;
