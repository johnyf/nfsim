% File:      voronoi_patches.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2010.09.15
% Language:  MATLAB R2011a
% Purpose:   polynomial navigation function in configuration space
% Copyright: Ioannis Filippidis, 2010-

function [nf] = voronoi_patches(agent, world, known_world)
x = agent.xcur;
xd = agent.xd;

[xi, ri] = convex2sphere_world(world, known_world);
[point_type, ~, idx_sorted, x_dist] = convex_voronoi(x, xi, world, known_world);

% is this a point within an obstacle?
if (point_type == -1)
    nf = 1;
    return;
end

idx = idx_sorted(1,1);
%% (A) does not belong to any weighted Voronoi cell
if (point_type == 0)
    %disp('Point does not belong to any Voronoi cell.')
    nf = phi(x, xd, xi, ri, [], [], idx);
    return;
end

%% (B) belongs to a weighted Voronoi cell
max_width = 15;

% (B.1) vs (B.2)

% (B.1) within the cell?
if (point_type == 1)
    % no
    % then find the ray's intersection with the cell's boundary

    % ray direction,from circle center to current configuration
    ray = x - xi(:,idx);
    ray = ray /norm(ray, 2); % unit vector

    % search for intersection with weighted Voronoi cell
    flag = 0;
    du = 0.1;
    x_end = x;
    while (flag == 0)
        x_end = x_end + ray * du;
        [point_type1, ~, ~, ~] = convex_voronoi(x_end, xi, world, known_world);

        % maximum cell width imposed to ensure termination even on
        % non-compact manifolds (infinite domains, but with finite number of obstacles)
        dist1 = norm(x_end - x_dist(:,idx), 2);

        % still inside, but now the max Voronoi cell distance reached
        if (point_type1 == 1) && (dist1 > max_width)
            flag = 1;
            continue;
        end

        % still inside, have not reached cell boundary, continue moving
        if (point_type1 == 1)
            continue;
        end

        % consider inequality checking, to find when we are nearly near
        % a gradient discontinuity


        % on bounary (nearly impossible to happen exactly)
        if (point_type1 == 2) || (point_type1 == 3)
            flag = 2;
            continue;
        end

        % just crossed boundary
        if (point_type1 == 0)
            flag = 3;
            continue;
        end
    end

    % now found intersection point
else
    % (B.2) on cell boundary
    x_end = x;
end

% Note: if on cell's boundary, we do not need to find the end point of this
% "circle-center through current configuration to cell boundary"
% ray. The mentioned end point is the intersection of the weighted
% Voronoi cell boundary with the current ray.
% The reason of not having to find this end point is that we are on
% the end point!

% by setting the endpoint equal to the current position, we can handle
% nf computation generically in each case of (B.1) and (B.2):
% (B.1): endpoint ~= current point
% (B.2): endpoint == current point

%% ===============
% Check 2
% Now we know we are within an obstacle's cell
% and if on the cell's boundary or inside the cell
% if on the boundary we are on our current ray's endpoint
% if not on the boundary, then we have also found the current ray's
% endpoint.
% What remains is to classify the ray type based on checking
% x_dist(:,1) (ray's intersection point with closest obstacle)
% 

% C^1 discontinuity causes
% (1) owner obstacle's corner -> x_dist(:,1)
% (2) Voronoi diagram branching point -> x_end
% (3) neighbor obstacle's corner -> x_dist(:,2)
% (4) maximum convex world distance of effect bounding weighted Voronoi
%     cell
if (point_type == 1)

end

% point belongs to closest obstacle's weighted Voronoi cell boundary
% the boundary is the bisector of 2 obstacles
if (point_type == 2)

end

% point belongs to >=3 obstacles, branching point
if (point_type == 3)

end

% CAUTION: The correct checking is done by checking if the calculated
% step crosses a discontinuity ray (if we are not on the boundary)
% and 

r_in = norm(x_dist(:,idx) - xi(:,idx), 2);
r_out = norm(x_end - xi(:,idx), 2);

nf = phi(x, xd, xi, ri, r_in, r_out, idx);

if (nf <= 0)
    error( ['Navigation function = ' num2str(nf) ' < 0!'] )
end

% Navigation function exact gradient (only when in pure attractive potential region)
function [gradphi] = gradphi(q, qd, ri, qi, ei)
gradphi = [];
