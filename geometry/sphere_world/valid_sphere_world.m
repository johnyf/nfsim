% File:      valid_sphere_world.m
% Author:    Ioannis Filippidis, Mechanical Engineer, jfilippidis@gmail.com
% Date:      2010.10.16
% Language:  MATLAB, program version: 7.11 (2010b)
% Purpose:   check sphere world validity (disjoint obstacles)
% Copyright: Ioannis Filippidis, 2010-

function [ok] = valid_sphere_world(qc, r, r0)

    M  = size(r,2); % # of obstacles
    ok = 1;
    
    % check obstacles are disjoint
    for i=1:M
        for j=1:(i-1)
            if norm(qc(:,i) - qc(:,j), 2) <= (r(1,i) +r(1,j))
                ok = 0;
                error( ['Sphere world is not valid! Obstacles: '...
                    num2str(i) ' and ' num2str(j) 'intersect!'] )
            end
        end
        
        % provided a boundary is given
        if isempty(r0)
            disp('Warning: No world radius given.')
            return
        end
        
        if r0 <= (norm(qc(:,i)) +r(i))
            ok = 0;
            error( ['Sphere world is not valid! Obstacles: 0 and'...
                num2str(i) 'intersect!'] )
        end
    end
end
