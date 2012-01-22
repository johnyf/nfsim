function [] = config_agent_call(src, varargin)
%% data in
S = guidata(src);

fig = S.fig(1);
agent = S.agent;
world = S.world;
h_map_ax = S.plots.h_map_ax;

if world_exists(world, 0)
    M = size(S.world.obstacles, 1);
else
    M = 0;
end

if known_world_exists(S, 0)
    known_world = S.known_world;
end

% current agent exists?
if agent_exists(agent, 0)
    agent = S.agent;
else
    % show default settings
    switch world.ndim
        case 2
            x0 = [0.5, 0.5]'; % initial
            xd = [1, 1]'; % goal (final/destination)
        case 3
            x0 = [0.5, 0.5, 0.5]';
            xd = [1, 1, 1]';
        otherwise
            error('World dimension different than 2 or 3.')
    end
    agent = init_agent('x0', x0, 'xd', xd, 'xcur', x0);
    known_world = set_known(1, known_world, M); % start default
end

% multiagent?
N_agents = size(agent.x0, 2);

%% graphics
h_dlg = dialog(...
    'units'     , 'pixels',...
    'position'  , [300, 300, 600, 200],...
    'menubar'   , 'none',...
    'name'      , 'Configure Agents',...
    'numbertitle','off',...
    'resize'    , 'off');

h_sensing = uicontrol(...
    'Parent'    , h_dlg,...
    'style'     , 'checkbox',...
    'units'     , 'normalized',...
    'position'  , [0.2, 0.1, 0.1, 0.1],...
    'string'    , 'Sensing',...
    'Callback'  , @agent_sensing_call);

h_agent_number = spinner(...
     'Parent'   , h_dlg,...
     'Position' , [100 100 60 40],...
     'Min'      , 1,...
     'Max'      , 25,...
     'StartValue',N_agents,...
     'Step'     , 1,...
     'Callback' , @agent_number_call);

[h_sensing_radius, h_sensing_radius_buttons] = spinner(...
     'Parent'   , h_dlg,...
     'Position' , [100 40 60 40],...
     'Min'      , 0.1,...
     'Max'      , 100,...
     'StartValue',agent.Rs,...
     'Step'     , 0.1,...
     'Callback' , @sensing_radius_call);

h_ok = uicontrol(...
    'Parent'    , h_dlg,...
    'units'     , 'normalized',...
    'position'  , [0.4, 0.1, 0.2, 0.2],...
    'string'    , 'OK',...
    'callback'  , @ok_call);

h_place_xd = uicontrol(...
    'Parent'    , h_dlg,...
    'units'     , 'normalized',...
    'position'  , [0.4, 0.3, 0.2, 0.2],...
    'string'    , 'Place Destination',...
    'callback'  , @place_destination_call);

h_place_x0 = uicontrol(...
    'Parent'    , h_dlg,...
    'units'     , 'normalized',...
    'position'  , [0.4, 0.5, 0.2, 0.2],...
    'string'    , 'Place Agent',...
    'callback'  , @place_agent_call);

% sensing?
if agent.sensing == 1
    set(h_sensing, 'Value', get(h_sensing,'Max'));
    set(h_sensing_radius, 'Enable', 'on');
    set(h_sensing_radius_buttons, 'Enable', 'on');
elseif agent.sensing == 0
    set(h_sensing, 'Value', get(h_sensing,'Min'));
    set(h_sensing_radius, 'Enable', 'off');
    set(h_sensing_radius_buttons, 'Enable', 'off');
end

update_plot

%% callbacks
function [] = agent_number_call(src, varargin)
    N_agents_old = N_agents;
    N_agents = get(h_agent_number, 'Value');

    %% not changes, only when N_agents = 1 and we press down button
    if N_agents_old == N_agents
        return
    end

    %% changed N_agents
    helpdlg(...
        'Changing the number of agents resets x0, xd, xcur, x.',...
        'Agent Number Change');

    %% Multiagent
    if N_agents > 1
        % Multiagent not yet implemented
        helpdlg(...
            'Multiagent navigation not integrated yet in GUI.',...
            'Multiagent navigation');
        N_agents = 1;
        set(h_agent_number, 'Value', 1);
        set(h_agent_number, 'String', 1);
    end
end

function [] = agent_sensing_call(src, varargin)
    if (get(h_sensing,'Value') == get(h_sensing,'Max'))
        sensing = 1;
        known_world = set_known(0, known_world, M);
        set(h_sensing_radius, 'Enable', 'on');
        set(h_sensing_radius_buttons, 'Enable', 'on');
    elseif (get(h_sensing,'Value') == get(h_sensing,'Min'))
        sensing = 0;
        known_world = set_known(1, known_world, M);
        set(h_sensing_radius, 'Enable', 'off');
        set(h_sensing_radius_buttons, 'Enable', 'off');
    end
    agent = init_agent(agent, 'sensing', sensing);
    update_plot
    plot_scalings(h_map_ax) % to show Rs
end

function [] = sensing_radius_call(src, varargin)
    agent.Rs = get(h_sensing_radius, 'Value');
    update_plot
    plot_scalings(h_map_ax) % to show Rs
end

function [x] = dlg_ginput_from(hdlg, fig, ax)
    %% 3D
    if size(agent.x0, 1) == 3
        set(hdlg, 'WindowStyle', 'normal')
        x = input_matrix( [3, 1] );
        set(hdlg, 'WindowStyle', 'modal')
        return
    end

    %% 2D
    set(hdlg, 'WindowStyle', 'normal')
    set(0, 'CurrentFigure', fig);
    set(fig, 'CurrentAxes', ax);
    x = ginput(1)';
    set(hdlg, 'WindowStyle', 'modal')
end

function [] = place_destination_call(src, varargin)
    disp('Give agent goal configuration')
    agent.xd = dlg_ginput_from(h_dlg, fig, h_map_ax);
    update_plot
    % no plot_scalings to allow zoom for detailed destination
    % placement
end

function [] = place_agent_call(src, varargin)
    disp('Give agent initial configuration x0')
    agent.x0 = dlg_ginput_from(h_dlg, fig, h_map_ax);
    agent.xcur = agent.x0;
    update_plot
    % no plot_scalings to allow zoom for detailed agent initial
    % placement
end

function [] = ok_call(src, varargin)
    S.agent = agent;
    S.known_world = known_world;
    update_guidata(S)

    update_plot

    check_navigate_ability(S, 1);
    closereq;
end

function [] = update_plot
    tempgui.fig = fig;

    % update only map, not field
    update_graphics(world, known_world, agent, tempgui, []);

    % field updated using panel controls (avoid code duplication)
    if check_navigate_ability(S, 0)
        slider_k_call(fig)
    end
end
end
