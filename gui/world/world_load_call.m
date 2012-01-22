function [] = world_load_call(scr, varargin)
    %% data in
    S = guidata(scr);
    
    fig = S.fig;
    world = S.world;
    known_world = S.known_world;
    sensed_world = S.sensed_world;
    agent = S.agent;
    selected_field = S.selected_field;
    
    %% main
    [filename, ~] = ...
        uigetfile({'*.mat'}, 'Select Scenario MAT-File');
    
    % no filename specified?
    if filename == 0
        return
    end
    
    fields = {'world', 'known_world'};
    loaded = load_scenario(filename, fields);
    
    check_navigate_ability(S);

    tempgui.fig = fig;
    update_graphics(world, known_world, sensed_world,...
        agent, tempgui, selected_field);
    plot_scalings(S.h_map_ax);
    
    %% data out
    S.world = loaded.world;
    S.known_world = loaded.known_world;
    
    update_guidata(S)
end