% File:      getGUISimParams.m
% Author:    Ioannis Filippidis, Mechanical Engineer, jfilippidis@gmail.com
% Date:      2010.12.14
% Language:  MATLAB, program version: 7.11 (2010b)
% Purpose:   get parameters selected in GUI as settings for simulation
% Copyright: Ioannis Filippidis, 2010-

function [agent, world, known_world, type, nfgui] = getGUISimParams(nfgui)
data = guidata(nfgui.fig);

defined = 1;

%% check & retrieve guidata
if isfield(data, 'selected_field')
    type = data.selected_field;
else
    defined = 0;
    warning('Field type not selected yet.')
end

if isfield(data, 'agent')
    agent = data.agent;
else
    defined = 0;
    warning('Agent not configured yet.')
end

if isfield(data, 'world')
    world = data.world;
else
    defined = 0;
    warning('World not defined yet.')
end

if isfield(data, 'known_world')
    known_world = data.known_world;
else
    defined = 0;
    warning('Known world not defined yet.')
end

%% something undefined!
if defined == 0
    error( ['Simulation can run only for fully defined scenarios.'...
        'Please set some of the following: agent, world, field type.'] )
end
