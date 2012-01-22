% File:      init_bezier_world.m
% Author:    Ioannis Filippidis, Mechanical Engineer, jfilippidis@gmail.com
% Date:      2010.09.13
% Language:  MATLAB, program version: 7.11 (2010b)
% Purpose:   initialize structure of bezier world
% Copyright: Ioannis Filippidis, 2010-

function [world, known_world, agent] = init_bezier_world(agent)

    temp_xcp = testcdc;
    
    % control points of obstacles
    nx = 2; %4;
    ny = 2; %4;
    obstacles = cell(nx*ny,1);
    k = 1;
    for i=1:nx
        for j=1:ny
            select_obstacle = k; %randi(4);
            obstacle_xcp = temp_xcp{select_obstacle};
            temp = ones(1, size(obstacle_xcp,2));
            obstacles{k,1}.xcp = obstacle_xcp +...
                [(-2 +temp * i); (-2 +temp *( 2*j + (-1)^i ) )];
            obstacles{k,1}.type = 1; % 1 = bezier
            k = k+1;
        end
    end
    
    % bezier coefficients of obstacles
    for i=1:size(obstacles,1)
        obstacles{i,1}.bezier_coef = control_points2bezier_coef(obstacles{i,1}.xcp);
    end
    
    world.obstacles = obstacles;
    world.r0 = +inf;
    world.ndim = size(world.obstacles{1,1}.xcp,1);
    
    known_world = []; % nothing known initially
end

% sample obstacles used
function [temp_xcp] = testcdc
    
    temp_xcp{1} = [0.1, 0.1, 0.5, 1.5, 0.2, 0.9, 0.5, 0.1, 0.1;
                   0.5, 0.9, 1.9, 2.0, 0.2, 0.1, 0.2, 0.1, 0.5];
            
    temp_xcp{2} = [0.1, 0.1, 0.5, 0.9, 0.8, 0.9, 0.5, 0.1, 0.1;
                   0.5, 0.9, 1.0, 0.9, 0.5, 0.1, 0.2, 0.1, 0.5];
            
    temp_xcp{3} = [1,0; 0.5,0; 0,2.5; -0.5,0; -1,0; -0.5,0.5; 0,-1; 0.5,0.5; 1,0]';
               
    temp_xcp{4} = [0.1, 0.1, 0.5, 0.9, 2.0, 0.9, 0.5, 0.1, 0.1;
                   0.5, 0.9, 1.5, 0.9, 0.5, 0.1, 0.2, 0.1, 0.5];
end

% sample obstacles used
function [temp_xcp] = candidate_obs
    
    temp_xcp{1} = [0.1, 0.1, 0.5, 0.9, 0.8, 0.9, 0.5, 0.1, 0.1;
                   0.5, 0.9, 1.9, 0.9, 0.5, 0.1, 0.2, 0.1, 0.5];
            
    temp_xcp{2} = [0.1, 0.1, 0.5, 0.9, 0.8, 0.9, 0.5, 0.1, 0.1;
                   0.5, 0.9, 1.0, 0.9, 0.5, 0.1, 0.2, 0.1, 0.5];
            
    temp_xcp{3} = [0.1, 0.1, 0.5, 0.9, 0.8, 0.9, 0.5, 0.1, 0.1;
                   0.5, 0.9, 2.5, 0.9, 0.5, 0.1, 0.2, 0.1, 0.5];
               
    temp_xcp{4} = [0.1, 0.1, 0.5, 0.9, 2.0, 0.9, 0.5, 0.1, 0.1;
                   0.5, 0.9, 1.5, 0.9, 0.5, 0.1, 0.2, 0.1, 0.5];
end
