function [] = enable_navigation(S)
    set(S.menus.h_uimenu_Navigation_item(2), 'Enable', 'on')
    
    set(S.panels.h_button_navigate, 'Enable', 'on')
    set(S.panels.h_slider_k, 'Enable', 'on')
    set(S.panels.h_auto_k, 'Enable', 'on')
    set(S.panels.h_field_plot_resolution, 'Enable', 'on')
    
    set(S.plots.h_field_ax, 'HitTest', 'on')
end