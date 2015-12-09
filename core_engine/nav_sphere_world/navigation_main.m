% File:      navigation_main.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2010.09.13 - 
% Language:  MATLAB R2010b
% Purpose:   navigation init and call loop
% Copyright: Ioannis Filippidis, 2010-

%% Init
[agent, world, known_world, type, nfgui] = getGUISimParams(nfgui);
valid_agent(agent, world, known_world)

nfgui = init_graphics(nfgui, world, known_world, agent);
known_world = rimon_init(known_world);

%% Run
[agent, world, known_world, sensed_world] =...
    navigate(agent, world, known_world, nfgui, type, 'on');
update_graphics(world, known_world, agent, nfgui, type);
