% File:      find_intersection.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2010.09.20 - 
% Language:  MATLAB R2010b
% Purpose:   find generalized Voronoi diagram branching point
% Copyright: Ioannis Filippidis, 2011-

function [x] = find_intersection(x, idx, world, known_world)
    id_cur = idx;
            
    % distance from known bezier part
    a1 = world.obstacles{id_cur,1}.bezier_coef; % retrieve this obstacle's bezier coefficients

    px1 = a1(1,:);
    py1 = a1(2,:);

    % bezier coef coordinate transform
    a = a1;
    a(:,end) = a1(:,end) - x; % translate to current position

    a = [cos(theta), sin(theta);
         -sin(theta),  cos(theta)] * a; % rotate to ray's coordinate axes

    py = a(2,:); % y bezier parametric polynomial
    t0 = roots(py);            
    t0 = t0(imag(t0) == 0); % keep real roots
    t0 = t0(t0 >= 0); % \in [0,1]
    t0 = t0(t0 <= 1);

    if isempty(t0)
        return;
    end

    % does it belong to this known segment?
    t1 = known_world(id_cur,2);
    t2 = known_world(id_cur,3);
    inter = known_world(id_cur,4);

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
        return;
    end

    % distance from straight edge        
    t = [t1, t2];
    x_ends = [polyval(px1, t);
              polyval(py1, t)];

    XY1 = [x_ends(1,1), x_ends(2,1), x_ends(1,2), x_ends(2,2)];
    XY2 = [xi(1,id_cur), xi(2,id_cur), x(1,1), x(2,1)];
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
            if ( (x_1(:,1) - x)' * (xi(:,id_cur) - x) ) <= 0
                inside = 1;
            else
                if ( norm(x_1(:,1) - x, 2) >= norm(xcenters(:,id_cur) - x, 2) )
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
        x_dist(:,id_cur) = x_temp1(:,1);
        return;
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
