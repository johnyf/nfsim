function [S] = initgui
fig = init_figure;
[h_zoom_all, h_draw_circle] = init_toolbars;
menus = init_menus(fig);
panels = init_panel(fig);
plots = init_plots(fig);
maximize(fig)

%% data out
S.fig = fig;
S.h_zoom_all = h_zoom_all;
S.h_draw_circle = h_draw_circle;
S.menus = menus;
S.panels = panels;
S.plots = plots;
