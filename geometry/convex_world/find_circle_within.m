% File:         find_circle_within.m
% Programmer:   John Filippidis, Mechanical Engineer, jfilippidis@gmail.com
% Date:         2010.09.15
% Language:     MATLAB, program version: 7.11 (2010b)
% Purpose:      find a circle within the convex obstacle
% Copyright:    John Filippidis, 2010-

function [xc, r, e, x] = find_circle_within(obstacle, part_known)

switch obstacle.type
    case 1
        [xc, r, e, x] = find_in_bezier(obstacle, part_known);
    case 2
        [xc, r, e, x] = find_in_circle(obstacle);
    case 0
        [xc, r, e, x] = find_in_circle(obstacle);
    otherwise
        error('Unknown obstacle type!')
end

function [xc, r, e, x] = find_in_bezier(obstacle, part_known)
t(1) = part_known(1,2);
t(2) = part_known(1,3);

inter = part_known(1,4);

% other points
if (inter == 0)
    t(3) = 2/3 *t(2) + 1/3 *t(1);
    t(4) = 1/3 *t(2) + 2/3 *t(1);
else
    t(4) = 1/3 + 2/3 *t(1);
    t(3) = 1/3 *t(2);

    % complete obstacle known?
    if (t(1) <= t(2))
        t = [0, 0.25, 0.75, 1];
    end
end

a = obstacle.bezier_coef;

px = a(1,:);
py = a(2,:);

x = [polyval(px,t);
     polyval(py,t)];

xc = mean(x, 2);

xdif = x - xc * ones(1, size(x,2));

xlines = x - [x(:,2:end), x(:,1)];
xlines = flipud(xlines);
xlines(1,:) = -xlines(1,:);

for i=1:4
    dist(i) = abs( xdif(:,i)' * xlines(:,i) /norm( xlines(:,i), 2) );
end
dist_min = min(dist);
r = 0.8 *dist_min; % circle NOT tangent to convex polygon
e = 0.2 *dist_min; % circle zone an annulus of width ei,
% so that the outer boundary of the zone is tangent to the closest side
% of the polygon. This way the circle and its zone of effect in the
% sphere world remain within the real obstacle.
% The diffeomorphism always transforms point from outside the obstacle
% to points outside the obstacle and within the (real) obstacle.
% If the zone is completely within the obstacle, we do not need to
% check that it does not intersect the outer boundary of the
% diffeomorphism zone (which may be arbitrarily close to the real
% obstacle, depending on the relative position of other obstacles.

function [xc, r, e, x] = find_in_circle(obstacle)
xc = obstacle.xobs;
r = obstacle.robs;
e = 0;
x = [];
