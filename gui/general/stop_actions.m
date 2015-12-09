function [] = stop_actions(S)
    % Navigate enable
    set(S.panels.h_button_navigate, 'Enable', 'on')
    set(S.menus.h_uimenu_Navigation_item(2), 'Enable', 'on')

    % Pause disable & string = pause
    set(S.panels.h_button_pause, 'Enable', 'off')
    set(S.panels.h_button_pause, 'String', 'Pause')
    set(S.menus.h_uimenu_Navigation_item(3), 'Enable', 'off')
    set(S.menus.h_uimenu_Navigation_item(3), 'label', 'Pause')

    % Stop disable
    set(S.panels.h_button_stop, 'Enable', 'off')
    set(S.menus.h_uimenu_Navigation_item(4), 'Enable', 'off')

    % field plot controls enable
    set(S.panels.h_slider_k, 'Enable', 'on')
    set(S.panels.h_auto_k, 'Enable', 'on')
    set(S.panels.h_field_plot_resolution, 'Enable', 'on')
    set(S.plots.h_field_ax, 'HitTest', 'on')
end