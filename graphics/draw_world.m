% File:      draw_world.m
% Author:    Ioannis Filippidis, Mechanical Engineer, jfilippidis@gmail.com
% Date:      2010.09.13
% Language:  MATLAB, program version: 7.11 (2010b)
% Purpose:   plot world
% Copyright: Ioannis Filippidis, 2010-

function [] = draw_world(varargin)

% [] = draw_world(world, known_world, agent)
% [] = draw_world(ax, world, known_world, agent)

%% varargin
if (nargin < 3) || (4 < nargin)
    error('This function takes 3 or 4 arguments.')
end

if ishandle(varargin{1} )
    ax = varargin{1};
    n = 2;
else
    ax = gca;
    n = 1;
end

world = varargin{n};
known_world = varargin{n +1};
agent = varargin{n +2};

hold(ax, 'on')

%% plot obstacles
draw_interior_obstacles(ax, world, known_world, agent);
grid(ax, 'on')

%% plot world boundary
%ndim = world.ndim;
%draw_world_boundary(ax, world, ndim);

hold(ax, 'off')

function [] = draw_interior_obstacles(ax, world, known_world, agent)
if ~isfield(world, 'obstacles') || isempty(world.obstacles)
    return
end

obstacles = world.obstacles;

nobs = length(obstacles);

if ~isempty(known_world) && isfield(known_world, 'id')
    id = known_world.id;
else
    id = [];
end

for i=1:nobs
    [~, index] = ismember(i, id);
    if index ~= 0
        col = [0.133, 0.5451, 0.133]; % unknown world
        part_shown = known_world.details{1, index};
    else
        %continue
        part_shown = [1, 0, 1, 1];
        col = [0, 0, 1]; % known world
    end
    
    obs = obstacles{i, 1};

    switch (obs.type)
        case 1
            t1 = part_shown(1, 2);
            t2 = part_shown(1, 3);
            inter = part_shown(1, 4);
            
            % w/o control points, w/o rays
            %bezier_draw(obs.bezier_coef, [],...
            %    t1, t2, inter, col, []);

            % w/o control points, with rays
            bezier_draw(ax, obs.bezier_coef, [],...
                t1, t2, inter, col, agent);

            % with control points
            %bezier_draw(obs.bezier_coef, obs.xcp,...
            %    t1, t2, inter, col, agent);
        case 2
            center_style = []; %'r+'
            
            xc = obs.xobs;
            r = obs.robs;
            
            ndim = size(xc, 1);
            
            if ndim == 2
                plot_circle(ax, xc, r, col, center_style, '-');
            end
            
            if ndim == 3
                % obstacle 0
                if r < 0
                    opacity = 0;
                else
                    opacity = 0;
                end
                
                plotSphere(ax, xc, r, 'Color', col, 'Opacity', opacity);
            end
        otherwise
            disp('Unknown obstacle type.')
    end
end

% function [] = draw_world_boundary(ax, world, ndim)
% if isempty(world)
%     return
% end
% 
% if ~isfield(world, 'r0')
%     return
% end
% 
% plot_circle(ax, zeros(ndim, 1), world.r0, 'b', 'r+');
