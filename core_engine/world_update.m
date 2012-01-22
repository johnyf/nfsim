% File:      world_update.m
% Author:    Ioannis Filippidis, Mechanical Engineer, jfilippidis@gmail.com
% Date:      2010.09.15
% Language:  MATLAB, program version: 7.11 (2010b)
% Purpose:   current + sensed world = updated world
% Copyright: Ioannis Filippidis, 2010-

function [new] = world_update(old, sensed)
%% nothing sensed
if isempty(sensed)
    new = old;
    new.discovered_obs = []; % no new disjoint obstacles found
    return
end

%% first discovery
if isempty(old.id)
    new = old;
    
    new.id = sensed.id;
    new.details = sensed.details;
    
    % all obstacles seen are new
    if ~isempty(sensed)
        new.newid = sensed.id;
    end
    return
end

%% nothing discovered?
Nsensed = size(sensed.id, 2);
newid = [];
details = {};

% each sensed
for i=1:Nsensed
    sensedid = sensed.id(1, i);
    
    % new?
    if ~ismember(sensedid, old.id)
        newid = [newid, sensedid];
        details = {details{1, :}, sensed.details{1, i} };
    end
end

new = old; % transfer other settings
new.id = [old.id, newid]; % new known ids
new.newid = newid; % ids discovered by current sensing
new.details = {old.details{1,:}, details{1,:} };
