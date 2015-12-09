function [X, Y, nf_field, px, py, fig] = ...
    update_nf_field(ax, agent, world, known_world, type, resolution)
% File:      update_nf_field.m
% Author:    Ioannis Filippidis, Mechanical Engineer, jfilippidis@gmail.com
% Date:      2010.12.14 - 
% Language:  MATLAB, program version: 7.11 (2010b)
% Purpose:   update potential field (within GUI axes)
% Copyright: Ioannis Filippidis, 2010-

if world.ndim > 2
    warning('World dimension > 2, field cannot be plotted.')
    return
end

limits = find_limits(agent, world, known_world);
n = [resolution, resolution];
[X, Y, nf_field, px, py, fig] = plotS_nf(ax, [], limits, n, type,...
                                         agent, world, known_world);

if resolution > 60
    shading(ax, 'interp')
end

function [limits] = find_limits(agent, world, known_world)

if ~isfield(world, 'obstacles')
    error('Field WORLD.OBSTACLES unitialized.')
end

if isempty(world.obstacles)
    maxdim = 0;
else
    % world dimensions
    n = size(world.obstacles, 1);
    known_world = set_known(1, known_world, n);
    [qc, r] = convex2sphere_world(world, known_world);

    l = vnorm(qc, 1, 2) +abs(r);

    maxdim = max(l);
end

% agent dimensions
x0 = agent.x0;
xd = agent.xd;
xcur = agent.xcur;
x = agent.x;

allx = [x0, xd, xcur, x];
nx = vnorm(allx, 1, 2);

maxdim = max( [nx, maxdim] );

limits = 1.05 .*[-maxdim, maxdim, -maxdim, maxdim];
