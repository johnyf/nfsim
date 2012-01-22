function [plots] = init_plots(fig)
figure(fig);
h_field_ax = subplot(1,2,1);
h_map_ax = subplot(1,2,2);

set(h_field_ax, 'Position', [0.15, 0.1, 0.35, 0.8]);
set(h_map_ax, 'Position', [0.55, 0.1, 0.35, 0.8]);

view(h_field_ax, 3);
grid(h_field_ax, 'on');
tex_plot_annot(h_field_ax, 'Potential Field',...
    '$x$', '$y$', '$\varphi$', [] );

view(h_map_ax, 2);
grid(h_map_ax, 'on');
box(h_map_ax, 'on');
tex_plot_annot(h_map_ax, 'World, Known World, Agent Path',...
    '$x$', '$y$', [], [] );

set(h_field_ax, 'HitTest', 'off')

% data out
plots.h_field_ax = h_field_ax;
plots.h_map_ax = h_map_ax;
