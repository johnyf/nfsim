function [world] = init_sphere_world
% File:      init_sphere_world.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2010.10.15
% Language:  MATLAB R2011b
% Purpose:   initialize structure of sphere world
% Copyright: Ioannis Filippidis, 2010-

candidates = sphere_world_candidates; % options
workspace = candidates{3}; % select

% Full C-space (known + unknown)
c_space.xobs = workspace.xobs;
c_space.robs = workspace.robs + workspace.ra;
c_space.r0 = workspace.r0 - workspace.ra;

%valid_sphere_world(c_space.xobs, c_space.robs, c_space.r0);
M = size(c_space.robs, 2);

%% World
obstacles = cell(M, 1);
for i=1:M
    obstacles{i,1}.type = 2; % 2=disk
    obstacles{i,1}.xobs = c_space.xobs(:,i);
    obstacles{i,1}.robs = c_space.robs(1,i);
end

obstacles{M+1, 1}.type = 2;
obstacles{M+1, 1}.xobs = zeros(size(c_space.xobs(:,i) ) );
obstacles{M+1, 1}.robs = -c_space.r0; % <0 !!!

world.obstacles = obstacles;
%world.r0 = c_space.r0;
world.ndim = size(c_space.xobs, 1);

%{
%% Agent (again)
agent.x0 = workspace.x0;
agent.xcur = agent.x0;
agent.xd = workspace.xd;
%}

% Real Workspaces to choose from
function [test] = sphere_world_candidates

% my test 1 -------------------
test{1}.name = 'simple-choset';
% Agent
test{1}.x0   = [-4.5; 0.01]; % initial x
test{1}.xd   = [-2; 2]; % destination x
test{1}.ra = 0; % agent radius in real workspace (not C-space)
% Obstacles
test{1}.xobs = [3,0; -3,0; 0,3; 0,-3; 0,0]';
test{1}.robs = [  1,    1,   1,    1,0.15];
test{1}.r0 = 5; % 0th obstacle radius (world radius)

% my test 2 -------------------
test{2}.name = 'difficult';

test{2}.x0   = [-4.25; 0];
test{2}.xd   = [4.25; 0];
test{2}.ra = 0;

test{2}.xobs = [3,0; -3,0; -0.2,3.6; 0,-3.5; 0,0; 0,-1.5; -3,-3; -2,-2]';
test{2}.robs = [  1,    1,        1,      1, 0.5,    0.3,   0.1,   0.1];
test{2}.r0 = 5;

% my test 3 -------------------
test{3}.name = 'very-difficult';

test{3}.x0   = [-1; 1];
test{3}.xd   = [4.1; 0];
test{3}.ra = 0;

test{3}.xobs = [-1.2,0; 3,0; -3,0; 0 ,3.5; 0,-3.5; 0,0; 0,1.6; 0,1]';
test{3}.robs = [   0.5,   1,    1,      1,      1, 0.5,   0.1, 0.1];
test{3}.r0 = 5;

% my test 4 -------------------
test{4}.name = 'still-very-difficult';

test{4}.x0   = [-3; 3];
test{4}.xd   = [4.25; 0];
test{4}.ra = 0;

test{4}.xobs = [3,0; -3,0; -0,3.5; 0,0; 0,1.6; 0,1]';
test{4}.robs = [  1,    1,      1, 0.5,   0.1, 0.1];
test{4}.r0 = 5;

% my test 5 -------------------
test{5}.name = 'rvachev test';

test{5}.x0   = [-1; 1];
test{5}.xd   = [4.1; 0];
test{5}.ra = 0;

test{5}.xobs = [-1.5,0; 0,-1.5; -3,0; 0 ,3.5; 0,-3.5; 0,0; 0,1.6; 0,1]';
test{5}.robs = [     1,   1,    1,      1,      1,   1,   1,    1];
test{5}.r0 = 5;

