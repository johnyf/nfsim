% File:      sensing_set.m
% Author:    Ioannis Filippidis, Mechanical Engineer, jfilippidis@gmail.com
% Date:      2010.09.12 - 
% Language:  MATLAB, program version: 7.11 (2010b)
% Purpose:   finds the new_t_limits = 
%               [id_1, t_min(id_1), t_max(id_1), intersection;
%               ...;
%               id_n, t_min(id_n), t_max(id_n), intersection]
% Copyright: Ioannis Filippidis, 2010-

function [new_t_limits] = sensing_set(agent, world)
% Note: sensing set implemented is a disk (2-ball), but may be any open
% subset S\in C-space

N_rays = 1000; % [-] number of sensing rays
% a sensing ray starts from the current position and extends to the
% maximum sensing distance at that direction.
% Here the sensing set is chosen to be a disk, so the sensing distance
% is the same in all directions. It is named the sensing radius: Rs.

% Note: when constructing a (real) space (known to this algorithm
% simulating reality but unknown to the agent) then a minimum obstacle
% radius of curvature r_curvature_min will result.
% By setting N_angular_resolution small enough that 2 consecutive rays
% intersect the sensing boundary (circle) at 2 points which are less
% than r_curvature_min away from each other, then no obstacle can come
% within the sensing set and not get detected.
% This way simulation (approximation) to the analytical solution of the
% problem will be better.
Rs = agent.Rs; % sensing radius (assuming the sensing set is a 2-ball)
xcur = agent.xcur; % current position (reference point of sensing set)

dtheta = 2*pi /N_rays; % [rad] angle between 2 consecutive sensing rays 
%fig2 = figure;
theta = 0; % [rad] angle of sensing ray with global coordinate system
for i=1:N_rays
    % for each of all the real obstacles
    x_closest = +inf; % distance of obstacle point closest to current position along this ray
    t_closest = 0; % parameter of closest point of closest obstacle along this ray
    j_closest = 0; % id of obstacle closest to current position along this ray
    
    for j=1:size(world.obstacles,1)
        a = world.obstacles{j,1}.bezier_coef; % retrieve this obstacle's bezier coefficients

        % bezier coef coordinate transform
        a(:,end) = a(:,end) - xcur; % translate to current position
        a = [cos(theta), -sin(theta);
             sin(theta),  cos(theta)] * a; % rotate to ray's coordinate axes

        py = a(2,:); % y bezier parametric polynomial
        t0 = roots(py);            
        t0 = t0(imag(t0) == 0); % keep real roots
        t0 = t0(t0 >= 0); % \in [0,1]
        t0 = t0(t0 <= 1);

        if isempty(t0)
            continue;
        end

        px = a(1,:);
        [~, idx] = min( abs( polyval(px,t0') ));
        tx_0 = t0(idx);
        x_0 = polyval(px,tx_0); % point on this ray for this obstacle

        % in positive direction? (ray is semi-infinite)
        if (x_0 < 0)
            continue;
        end

        % agent sees so far?
        if (x_0 >= Rs)
            continue; % NO!
        end

        % obstacle closest so far?
        if (x_0 < x_closest)
            x_closest = x_0;
            t_closest = tx_0;
            j_closest = j;
        end
        % Note: 2 different obstacles on the SAME ray cannot have equal
        % distances from the current position because the obstacles are
        % disjoint.
    end

    % The previous loop has found that ALONG THE CURRENT sensing ray
    % there is either no obstacle seen within sensing range Rs
    % or the closest obstacle seen is obstacle j_closest at
    % distance x_closest
    % its point of parameter t_closest

    % remember obstacle id and point parameter t for this obstacle
    closest_obstacle_ray(i,:) = [j_closest, t_closest];

    theta = theta + dtheta; % next ray...
end

%closest_obstacle_ray

% group visible points per obstacle
t1 = [];
t2 = [];
id = [];
k = 0;
last = -1;
for i=1:size(closest_obstacle_ray,1)
    id_cur = closest_obstacle_ray(i,1);

    if id_cur == 0
        continue;
    end

    % already stored another point of this obstacle?
    if last ~= id_cur
        % add obstacle to list
        k = k+1;
        id(k,1) = id_cur;
        % 1st point => t_min = t_max
        t1(k,1) = closest_obstacle_ray(i,2);
        t2(k,1) = closest_obstacle_ray(i,2);
    else
        % check endpoints of obstacle segment in list 
        t2(k,1) = closest_obstacle_ray(i,2);
    end

    last = id_cur;
end

% if when started scanning an obstacle was visible which was also
% visible when finishing scanning, then the two intervals are
% continuous (we have turned around a complete circle and met our
% tail), since this is S^{1}.
if isempty(id)
    new_t_limits = [];
    return
end

if id(1,1) == id(k,1)
    % merge them
    t1(1,1) = t1(k,1);

    % delete last interval
    id = id(1:(k-1),1);
    t1 = t1(1:(k-1),1);
    t2 = t2(1:(k-1),1);
end

inter = zeros(size(id,1),1);
for i=1:size(id,1)
    if (t1(i,1) < t2(i,1))
        inter(i,1) = 1;
    end

    temp = t2(i,1);
    t2(i,1) = t1(i,1);
    t1(i,1) = temp;
end

% ignore single points discovered, they lead to numerical problems
% later to find line-curve intersections
k = 0;

id_temp = [];
t1_temp = [];
t2_temp = [];
inter_temp = [];
for i=1:size(id,1)
    if (t1(i,1) == t2(i,1))
        continue;
    end

    k = k + 1;

    id_temp(k,1) = id(i,1);
    t1_temp(k,1) = t1(i,1);
    t2_temp(k,1) = t2(i,1);
    inter_temp(k,1) = inter(i,1);
end

id = id_temp;
t1 = t1_temp;
t2 = t2_temp;
inter = inter_temp;

new_t_limits = [id, t1, t2, inter];
end
