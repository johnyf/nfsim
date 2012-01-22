function [q, qd, qc, r0, r, k] = world2krnfs(agent, world, known_world)
% File:      world2krnfs.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2010.10.16 - 2011.07.29
% Language:  MATLAB R2011a
% Purpose:   convert world data structure to sphere world variables
% Copyright: Ioannis Filippidis, 2010-

% todo:
%new session
%delete obstacle
%show only level sets

% get sphere world info
[qc, r] = convex2sphere_world(world, known_world);

r0 = -r(r < 0);
qc = qc(:, r > 0);
r = r(r > 0);
q = agent.xcur;
qd = agent.xd;

% no known_world returned (updates happen in gradient_rimonS
% if strcmp(known_world.k_mode, 'auto')
%     known_world = k_update(known_world, q, qd, qc, r0, r);
% end
k = known_world.k;
