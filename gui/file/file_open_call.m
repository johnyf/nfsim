function [] = file_open_call(scr, eventdata)
%% get data    
S = guidata(scr);

h_map_ax = S.plots.h_map_ax;
fig = S.fig(1);
h = S.panels.h_auto_k;
k_mode = S.known_world.k_mode;

%% main
[filename, pathname] = ...
    uigetfile({'*.mat'}, 'Select Scenario MAT-File');

% no filename?
if filename == 0
    return
end

fields = {'world', 'known_world', 'agent', 'selected_field'};
loaded = load_scenario(filename, fields);
[agent, world, known_world] = getgui_problem(loaded);
selected_field = loaded.selected_field;

if strcmp(k_mode, 'auto')
    set(h, 'Value', get(h,'Max') )
    disp('Simulation will run with k automatically calculated.')
elseif strcmp(k_mode, 'manual')
    set(h, 'Value', get(h,'Min') )
    disp('Simulation will run with k selected using Control Panel slider.')
end

check_navigate_ability(S);

tempgui.fig = fig;
update_graphics(world, known_world, agent, tempgui, selected_field);
plot_scalings(h_map_ax);

%% data out
S.agent = agent;
S.world = world;
S.known_world = known_world;
S.selected_field = selected_field;

update_guidata(S)
