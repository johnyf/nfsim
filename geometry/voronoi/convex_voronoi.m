function [point_type, dist_sorted, idx_sorted, x_dist] = ...
                        convex_voronoi(x, xcenters, world, known_world)
% File:      convex_voronoi.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2010.09.15
% Language:  MATLAB R2010b
% Purpose:   convex world weighted Voronoi diagram point classification
% Copyright: Ioannis Filippidis, 2010-
    
% find intersection points
dist = [];
for i=1:size(known_world.id,2)        
    id_cur = known_world.id(1,i);

    if world.obstacles{id_cur, 1}.type ~= 1
        continue;
    end

    % distance from known bezier part
    a1 = world.obstacles{id_cur,1}.bezier_coef; % retrieve this obstacle's bezier coefficients

    px1 = a1(1,:);
    py1 = a1(2,:);

    % bezier coef coordinate transform
    a = a1;
    a(:,end) = a1(:,end) - x; % translate to current position

    vec2center = xcenters(:,i) - x;
    theta = atan2(vec2center(2,1), vec2center(1,1));

    a = [cos(theta), sin(theta);
         -sin(theta),  cos(theta)] * a; % rotate to ray's coordinate axes

    py = a(2,:); % y bezier parametric polynomial
    t0 = roots(py);            
    t0 = t0(imag(t0) == 0); % keep real roots
    t0 = t0(t0 >= 0); % \in [0,1]
    t0 = t0(t0 <= 1);

    if isempty(t0)
        continue;
    end

    details = known_world.details{1,i};

    % does it belong to this known segment?
    t1 = details(1,2);
    t2 = details(1,3);
    inter = details(1,4);

    if (inter == 0)
        t0 = t0(t0 >= t1);
        t0 = t0(t0 <= t2);
    elseif (t1 > t2)
        % obstacle not completely known
        t0_1 = t0(t0 >= t1); % one OR the other
        t0_2 = t0(t0 <= t2);
        t0 = [t0_1; t0_2];
    end

    px = a(1,:);
    [temp1, temp1_idx] = min( abs( polyval(px,t0') ));
    x_temp1 = [polyval(px1, t0(temp1_idx) );
               polyval(py1, t0(temp1_idx) )];

    t0 = t0';

    x_1 = [polyval(px1, t0 );
           polyval(py1, t0 )];

    % obstacle completely known => no straight-edge remains
    if (inter == 1) && (t1 <= t2)
        if ( (x_1(:,1) - x)' * (x_1(:,2) - x) ) <= 0

            point_type = -1;
            dist_sorted = [];
            idx_sorted = [];
            x_dist = [];
            disp('In obstacle 1!')
            return;
        end

        %disp( ['Case 1' num2str(id_cur)] )
        dist(i,1) = temp1;
        x_dist(:,i) = x_temp1(:,1);
        continue;
    end

    % distance from straight edge        
    t = [t1, t2];
    x_ends = [polyval(px1, t);
              polyval(py1, t)];

    XY1 = [x_ends(1,1), x_ends(2,1), x_ends(1,2), x_ends(2,2)];
    XY2 = [xcenters(1,i), xcenters(2,i), x(1,1), x(2,1)];
    out = lineSegmentIntersect(XY1, XY2);

    if (out.intAdjacencyMatrix == 0)
        inside = 0;
        if (size(x_1,2) == 2)
            % 2 intersections with bezier
            % = corresponds to the point being ON the boundary
            if ( (x_1(:,1) - x)' * (x_1(:,2) - x) ) <= 0
                inside = 1;
            end
        else
            % 1 intersection with bezier

            % intersection & center in same direction
            if ( (x_1(:,1) - x)' * (xcenters(:,i) - x) ) <= 0
                inside = 1;
            else
                if ( norm(x_1(:,1) - x, 2) >= norm(xcenters(:,i) - x, 2) )
                    inside = 1;
                end
            end
        end

        if (inside == 1)
            point_type = -1;
            dist_sorted = [];
            idx_sorted = [];
            x_dist = [];
            disp('In obstacle 2!')
            return;
        end

        %disp( ['Case 2' num2str(id_cur)] )
        dist(i,1) = temp1;
        x_dist(:,i) = x_temp1(:,1);
        continue;
    end

    x_temp2 = [out.intMatrixX(1,1);
               out.intMatrixY(1,1)];

    vec = x_temp2 - x;

    temp2 = norm(vec, 2);

    if (temp1 < temp2)
        %disp( ['Case 3' num2str(id_cur)] )
        dist(i,1) = temp1;
        x_dist(:,i) = x_temp1(:,1);
    elseif (temp2 <= temp1)
        %disp( ['Case 4' num2str(id_cur)] )
        dist(i,1) = temp2;
        x_dist(:,i) = x_temp2(:,1);
    end
end

%[dist_min, dist_min_idx] = min(dist);
%dist_min_id(:,1) = known_world(dist_min_idx,1);

[dist_sorted, idx_sorted] = sort(dist, 1, 'ascend');

%dist_sorted
%known_world( idx_sorted(:,1), 1)

point_type = 0;

%%
% Weighted Voronoi decision

% point belongs to closest obstacle's weighted Voronoi cell
if (dist_sorted(1,1) < 0.7 *dist_sorted(2,1))
    point_type = 1;
end

% point belongs to closest obstacle's weighted Voronoi cell boundary
% the boundary is the bisector of 2 obstacles
if (dist_sorted(1,1) == 0.7 *dist_sorted(2,1)) && (dist_sorted(2,1) < dist_sorted(3,1))
    point_type = 2;
end

% point belongs to >=3 obstacles, branching point
if (dist_sorted(1,1) == 0.7 *dist_sorted(2,1)) && (dist_sorted(2,1) == dist_sorted(3,1))
    point_type = 3;
end
%{
%%
% Display decision
disp('Weighted Voronoi: ')
switch point_type
    case 0
        disp('Point does not belong to any obstacle.')
    case 1
        disp( ['Point belongs to obstacle with id = '...
            num2str(known_world(idx_sorted(1,1), 1) )] )
    case 2
        disp( ['Point belongs to obstacles with ids = '...
            num2str(known_world(idx_sorted(1:2,1), 1) )] )
    case 3
        disp( ['Point belongs to >= 3 obstacles with first 3 ids = '...
            num2str(known_world(idx_sorted(1:3,1), 1) )] )
        disp('Weighted Voronoi diagram branching point')
    otherwise
        disp('Unknown Voronoi point type.')
end
%}
