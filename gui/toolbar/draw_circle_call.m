function [] = draw_circle_call(src, varargin)
%% get data
S = guidata(src);

menu = S.menus.h_uimenu_World_place_obstacle;
button = S.h_draw_circle;
fig =S.fig(1);

%% main
if gcbo == menu;
    button_call = get(button, 'OnCallback');
    set(button, 'OnCallback', '');

    set(button, 'State', 'on');

    set(button, 'OnCallback', button_call);
end
set(menu, 'Enable', 'off')

% any obstacles already defined?
if world_exists(0) && isfield(S.world, 'obstacles')
    obstacles = S.world.obstacles;
else
    obstacles = {};
end
nextid = size(obstacles, 1) +1;

known_world = S.known_world;
if agent_exists(0) && isfield(S.agent, 'sensing')
    known = ~S.agent.sensing;
else
    known = 1;
end

% continuous circle placement
tempgui.fig = S.fig(1);
continue_circles = 1;
while continue_circles == 1
    [ch, xc, r] = insert_sphere(S.world.ndim, [], [], [], [], button);
    if isempty(ch)
        continue_circles = 0;
    else
        new_obstacle = [];
        new_obstacle.type = 2;
        new_obstacle.xobs = xc;
        new_obstacle.robs = r;

        obstacles{nextid, 1} = new_obstacle;

        %known_world.parts(nextid, :) = [nextid, 1, 1, 1];
        known_world = set_known(known, known_world, nextid);
        known_world.idx = zeros(1, nextid);

        nextid = nextid +1;
    end
end

S.world.obstacles = obstacles;
S.known_world = known_world;

set(button, 'State', 'off');
set(menu, 'Enable', 'on')

if check_navigate_ability(S, 0)
    dummyworld = S.world;
    update_graphics(dummyworld, known_world, S.agent, tempgui, []);

    slider_k_call(fig)
end

update_guidata(S)
