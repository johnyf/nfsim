% File:         plot_transformation.m
% Programmer:   John Filippidis, Mechanical Engineer, jfilippidis@gmail.com
% Date:         2010.09.18
% Language:     MATLAB, program version: 7.11 (2010b)
% Purpose:      plot diffeomorphism
% Copyright:    John Filippidis, 2010-

function [] = plot_transformation(idx, world, known_world)
    close all
    
    % Show the diffeomorphism from an obstacle as seen in the known world
    % to a spher, keeping the boundary fixed.
    
    %% Parameters
    N_rays = 10;
    N_closed_curves = 5;
    
    %% Initialize
    X = linspace(0, 2*pi, N_rays+1);
    X = X(1:(end-1)); % last point dropped because is the same ray with 1st
    Y = linspace(0, 1, N_closed_curves);
    
    Z = meshgrid(X,Y);
    W = Z; % just initialize memory
    
    n = size(known_world,1);
    xi = zeros(size(x,1), n);
    ri = zeros(1,n);

    % select centers & circles
    for j=1:size(known_world,1)
        id_cur = known_world(j,1);
        obs = world.obstacles{id_cur,1};
        part_known = known_world(j,:);
        [xcenter_temp, r_temp, e_temp] = find_circle_within(obs, part_known);
        xi(:,j) = xcenter_temp;
        ri(1,j) = r_temp;
    end
    
    %% Calculate
    for i=1:N
        for k=1:N
            
            theta = X(i);
            
            find_intersection(xi, idx, world, known_world);
            
            
            
            
            % ray direction,from circle center to current configuration
            ray = x - xi(:,j);
            ray = ray /norm(ray, 2); % unit vector
            
            % search for intersection with weighted Voronoi cell
            flag = 0;
            du = 0.1;
            x_end = 0;
            while (flag == 0)
                x_end = x_end + ray * du;
                [point_type1, dist_sorted1, idx_sorted1, x_dist1] = convex_voronoi(x_end, xi, world, known_world);

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
            
            % voronoi
            [point_type, dist_sorted, idx_sorted, x_dist] = convex_voronoi(x, xi, world, known_world);
            
            % is this a point within an obstacle?
            if (point_type == -1)
                nf = 1;
                continue;
            end
            %{
        % plot Voronoi rays from xcur to xcircles
        for i=1:size(x_dist,2)
            hold on
            plot( [x(1,1), x_dist(1,i)], [x(2,1), x_dist(2,i)] )
            hold off
        end
            %}
            
            idx = idx_sorted(1,1);
            %% ========
            % Choose point case: A vs B
            
            % (A) does not belong to any weighted Voronoi cell
            if (point_type == 0)
                %disp('Point does not belong to any Voronoi cell.')
                nf = phi(x, xd, xi, ri, [], [], idx);
                continue;
            end
            
            % (B) belongs to a weighted Voronoi cell
            
            max_width = 15;
            
            %% ========
            % Check 1
            % (B.1) vs (B.2)
            
            % (B.1)
            % within the cell?
            if (point_type == 1)
                % no
                % then find the ray's intersection with the cell's boundary
                
                % ray direction,from circle center to current configuration
                ray = x - xi(:,j);
                ray = ray /norm(ray, 2); % unit vector
                
                % search for intersection with weighted Voronoi cell
                flag = 0;
                du = 0.1;
                x_end = x;
                while (flag == 0)
                    x_end = x_end + ray * du;
                    [point_type1, dist_sorted1, idx_sorted1, x_dist1] = convex_voronoi(x_end, xi, world, known_world);
                    
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
                % (B.2)
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
                x_end = x;
            end
            
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
            
            W(:,i,k) = diffeomorphism(x, xi, ri, r_in, r_out);
        end
    end

    %% Plot
    
    % graphing settings
    lw = 2;
    mycolor = [1, 0, 0.1];
    small = 0.1;

    figure;
    
    % Initial domain
    subplot(1,2,1)
    %clf;
    hold on;
    for i=1:N
      plot(X(:, i), Y(:, i), 'linewidth', lw, 'color', mycolor);
      plot(X(i, :), Y(i, :), 'linewidth', lw, 'color', mycolor);
    end
    axis([-1-small, 1+small, -1-small, 1+small]);
    axis equal;
    axis off;

    % Final domain
    subplot(1,2,2)
    %clf;
    hold on;
    for i=1:N
      plot(Z(:, i), W(:, i), 'linewidth', lw, 'color', mycolor);
      plot(Z(i, :), W(i, :), 'linewidth', lw, 'color', mycolor);
    end
    axis([-1-small, 1+small, -1-small, 1+small]);
    axis equal;
    axis off;
end
