function [] = slider_k_call(fig)
    %% get data
    S = guidata(fig);
    
    [agent, world, known_world] = getgui_problem(S);
    [~, ~, ~, ~, ax1] = getgui_objhandles(S);
    
    h_slider_k = S.panels.h_slider_k;
    
    type = S.selected_field;
    resolution = S.field_resolution;
    
    %{
    if evalin('base', 'exist(''known_world'')')
        %known_world = evalin('base','known_world'); % current
        known_world = S.known_world;
    else
        known_world = S.known_world;
    end
    %}

    %% work
    known_world.k = get(h_slider_k, 'Value');
    
    update_nf_field(ax1, agent, world, known_world, type, resolution);

    %% data out
    S.known_world = known_world;
    
    set(gcbo, 'userdata', 1);
    update_guidata(S)
end