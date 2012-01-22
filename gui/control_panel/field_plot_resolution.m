function [] = field_plot_resolution(src, varargin)
    %% get data
    S = guidata(src);
    
    fig = S.fig;
    h_field_plot_resolution = S.panels.h_field_plot_resolution;

    %% main
    resolution = get(h_field_plot_resolution, 'Value');
    resolution = round(resolution);
    set(h_field_plot_resolution, 'Value', resolution);

    slider_k_call(fig) % plot
    
    %% data out
    S.field_resolution = resolution;
    update_guidata(S)
end