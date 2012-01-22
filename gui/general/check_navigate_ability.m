function [ability] = check_navigate_ability(S, varargin)
    if nargin == 1
        output = 1;
    else
        output = varargin{1};
    end

    if output == 1
        disp('------------------------')
    end

    agent = S.agent;
    world = S.world;
    selected_field = S.selected_field;
    
    % all checked to provide diagnostics
    agent = agent_exists(agent, output);
    world = world_exists(world, output);
    known_world = known_world_exists(S, output);
    type = type_exists(selected_field, output);

    ability = agent && world && known_world && type;

    if ability
        enable_navigation(S)
    else
        disable_navigation(S)
    end
end
