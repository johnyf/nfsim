% File:      plotS_sphere_effect_zones.m
% Author:    Ioannis Filippidis, Mechanical Engineer, jfilippidis@gmail.com
% Date:      2010.09.29
% Language:  MATLAB, program version: 7.11 (2010b)
% Purpose:   given points and sphere world centers & radii,
%            plots points, obstacles and effect zones
% Copyright: Ioannis Filippidis, 2010-

% q = [q(:,1), q(:,2), ..., q(:,np)]; % various configurations
%                                           (points in C-space)
% qi = [qi(:,1), qi(:,2), ..., qi(:,n)]; % centers of sphere obstacles
% ri = [r1, r2, ..., rn]; % obstacle radii

function plotS_sphere_effect_zones(q, qi, ri)
[idx, e] = find_ei(q, qi, ri);

hold on
plot(q(1,:), q(2,:), '+r') % points

plot_circle(qi, ri, 'b-', 'b+'); % obstacles, with centers
plot_circle(qi, ri+e, 'g', []); % effect zones, no centers

hold on

% connect point to center of obstacle which affects it
for i=1:size(idx,2)
    if idx(1,i) == -1
        continue;
    else
        j = idx(1,i);
        plot( [q(1,i), qi(1,j)], [q(2,i), qi(2,j)], 'b')
    end
end

grid on
title('Obstacles, effect zones and points')
xlabel('x')
ylabel('y')

hold off
