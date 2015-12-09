% File:      plot_circles_polygons_rays.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2010.09.25
% Language:  MATLAB, program version: 7.11 (2010b)
% Purpose:   plot equivalent sphere world circles and rays to their centers
% Copyright: Ioannis Filippidis, 2010-

function [] = plot_circles_polygons_rays(agent, world, known_world)
xcur = agent.xcur;

[xi, ~] = convex2sphere_world(world, known_world);
[~, ~, ~, x_dist] = convex_voronoi(xcur, xi, world, known_world);

for i=1:size(x_dist,2)
    id_cur = known_world(i,1);
    obs = world.obstacles{id_cur,1};
    part_known = known_world(i,:);
    [xi, ri, ~, xpolygon] = find_circle_within(obs, part_known);

    % inscribed polygon
    x1 = [xpolygon, xpolygon(:,1)]; % close polygon

    hold on
    plot(x1(1,:), x1(2,:), 'b--')

    % plot Voronoi ray from xcur to circle center
    plot( [xcur(1,1), x_dist(1,i)], [xcur(2,1), x_dist(2,i)] )

    % contained circle
    plot_circle(xi, ri, 'g-', 'b+')
end
hold off

draw_world(world, known_world, [])
