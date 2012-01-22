function [] = pause_actions(S)
    % Resume enable & string
    set(S.panels.h_button_pause, 'Enable', 'on')
    set(S.panels.h_button_pause, 'String', 'Resume')
    set(S.menus.h_uimenu_Navigation_item(3), 'Enable', 'on')
    set(S.menus.h_uimenu_Navigation_item(3), 'label', 'Resume')

    % field plot controls enable
    set(S.panels.h_slider_k, 'Enable', 'on')
    set(S.panels.h_auto_k, 'Enable', 'on')
    set(S.panels.h_field_plot_resolution, 'Enable', 'on')
    set(S.plots.h_field_ax, 'HitTest', 'on')
end