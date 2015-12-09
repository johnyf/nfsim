function [] = disable_navigation(S)
    set(S.menus.h_uimenu_Navigation_item(2), 'Enable', 'off')
    
    set(S.panels.h_button_navigate, 'Enable', 'off')
    set(S.panels.h_slider_k, 'Enable', 'off')
    set(S.panels.h_auto_k, 'Enable', 'off')
    set(S.panels.h_field_plot_resolution, 'Enable', 'off')
    
    set(S.plots.h_field_ax, 'HitTest', 'off')
end