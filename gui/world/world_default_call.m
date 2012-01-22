function [] = world_default_call(src, varargin)
    %% data in
    S = guidata(src);
    
    [fig, ~, ~, h_map_ax, ~] =...
        getgui_objhandles(S);
    [agent, ~, known_world] = getgui_problem(S);
    
    %% main
    choice = questdlg(...
        'Would you like existing world replaced with default?', ...
        'Replace with Default World',...
        'Yes', 'No', 'No');
    % Handle response
    if strcmp(choice, 'No')
        return
    end

    world = init_sphere_world;

    if agent_exists(agent, 0) && isfield(agent, 'sensing') && ...
            (agent.sensing == 1)
        known = 0;
    else
        known = 1;
    end

    if world_exists(world, 0)
        M = size(world.obstacles, 1);
    else
        M = 0;
    end

    known_world = set_known(known, known_world, M);

    tempgui.fig = fig;
    update_graphics(world, known_world, agent, tempgui, [] );
    plot_scalings(h_map_ax);

    if check_navigate_ability(S, 0)
        slider_k_call(fig)
    end
    
    %% data out
    S.world = world;
    S.known_world = known_world;
    update_guidata(S)
end
