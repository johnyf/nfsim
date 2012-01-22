function [stop] = update_graphics(world, known_world, agent, nfgui, type)
% File:      update_graphics.m
% Author:    Ioannis Filippidis, Mechanical Engineer, jfilippidis@gmail.com
% Date:      2010.09.13 - 
% Language:  MATLAB, program version: 7.11 (2010b)
% Purpose:   update plot graphics in gui
% Copyright: Ioannis Filippidis, 2010-

%% data in
S = guidata(nfgui.fig);
ax1 = S.plots.h_field_ax;
ax2 = S.plots.h_map_ax;
hpause = S.panels.h_button_pause;
hstop = S.panels.h_button_stop;

%% Potential Field
%{
% Sphere world, Type = Rimon
if ~isempty(type) && strcmp(type, 'krnfs')
    % hence k used
    
    % remember previous k?
    if isfield(nfgui, 'field_parameter')
        kold = nfgui.field_parameter;
        % newer valid, even if it remains the same
        nfgui.field_parameter = known_world.k;
    else
        kold = []; % forced field update
    end
    
    % field update needed?
    if isfield(known_world, 'k') && (~isequal(known_world.k, kold) ||...
            ~isempty(known_world.newid) )
        [X, Y, ~, px, py, ~] = ...
            update_nf_field(ax1, agent, world, known_world,...
                type, S.field_resolution);
    end

end

% other world?

%}
%% Agent, World, Known World

v = axis(ax2);
cla(ax2);

hold(ax2, 'on')
if exist('X')
    quiver(ax1, X, Y, -px, -py, 'Color', 'b')
end
hold(ax2, 'off')

if ~isempty(agent)
    plot_path(ax2, agent) % called 1st to allow axis equal to remain
end

% if ~isempty(world)
%     draw_world(ax2, world, [], [])
% end

if ~isempty(world) && isfield(world, 'obstacles') && ~isempty(known_world)
    draw_world(ax2, world, known_world, [])
end
%title(ax2, 'World, Known World, Agent Path')
axis(ax2, v);

%% refresh
drawnow;

%% gui pause?
if strcmp(get(hpause, 'String'), 'Resume')
    uiwait;
end

%% gui stop?
if strcmp(get(hstop, 'Enable'), 'off')
    stop = 1;
    return
end

stop = 0;
