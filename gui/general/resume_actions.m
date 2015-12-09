function [] = resume_actions(S)
    % Navigate disable
    set(S.panels.h_button_navigate, 'Enable', 'off')
    set(S.menus.h_uimenu_Navigation_item(2), 'Enable', 'off')

    % Stop enable
    set(S.panels.h_button_stop, 'Enable', 'on')
    set(S.menus.h_uimenu_Navigation_item(4), 'Enable', 'on')

    % Pause enable & string
    set(S.panels.h_button_pause, 'Enable', 'on')
    set(S.panels.h_button_pause, 'String', 'Pause')
    set(S.menus.h_uimenu_Navigation_item(3), 'Enable', 'on')
    set(S.menus.h_uimenu_Navigation_item(3), 'label', 'Pause')

    % field plot controls disable
    set(S.panels.h_slider_k, 'Enable', 'off')
    set(S.panels.h_auto_k, 'Enable', 'off')
    set(S.panels.h_field_plot_resolution, 'Enable', 'off')
    set(S.plots.h_field_ax, 'HitTest', 'off')

    uiresume
end