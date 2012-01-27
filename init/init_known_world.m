function [known_world] = init_known_world(known, M)
% File:      init_known_world.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2010.12.23
% Language:  MATLAB R2011b
% Purpose:   initialize structure of known world
% Copyright: Ioannis Filippidis, 2010-

% known = 1; % 1=known | 0=unknown

known_world = [];

known_world = set_known(known, known_world, M);
known_world.k = 3;
known_world.newid = [];
known_world.idx = zeros(1,M+1);

% if k is adaptive, world exploration necessitates calculating new ei to
% use when finding k taking into account e3 zone history
known_world.update = 'needed';

% Change parameter k while simulating, either because of exploration, or
% because some obstacles have not come closer than their e3 zone until now
known_world.k_mode = 'manual';
