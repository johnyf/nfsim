function [] = world_boundary_call(src, varargin)
%% get data
S = guidata(src);

ndim = S.world.ndim;
button = S.h_draw_circle;
h_map_ax = S.plots.h_map_ax;
fig = S.fig;

agent = S.agent;
world = S.world;
known_world = S.known_world;

%% main
q0 = zeros(ndim, 1);
[ch, ~, r0] = insert_sphere(ndim, [], q0, [], [], button);
if ~isempty(ch)
    world = set_world_boundary(world, q0, r0);
end

if agent_exists(0) && isfield(agent, 'sensing')
    known = ~agent.sensing;
else
    known = 1;
end

if world_exists(0) && isfield(world, 'obstacles')
    M = size(world.obstacles, 1);
else
    M = 0;
end

known_world = set_known(known, known_world, M);

check_navigate_ability(S);

tempgui.fig = fig;

% update only map, not field
update_graphics(world, known_world, agent, tempgui, []);
plot_scalings(h_map_ax);

% field updated suing panel controls (avoid code duplication)
if check_navigate_ability(S, 0)
    slider_k_call(fig)
end

%% data out
S.world = world;
S.known_world = known_world;

update_guidata(S)
