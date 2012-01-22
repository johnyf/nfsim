% File:      semi_analytic_gradient.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2010.10.02 - 
% Language:  MATLAB R2010b
% Purpose:   semi-analytical gradient:
%               analytical in one direction, analytical on its normal
% Copyright: Ioannis Filippidis, 2011-

function [semi_analytic_grad_phi] = semi_analytic_gradient(...
    agent, world, known_world, type)
    
    switch type
        case 'nf_polynomial'
            nf = @lio_pap_kyr;
        otherwise
            error( ['Unknown navigation function type: ' type] )
    end
    
    x = agent.xcur;
    xd = agent.xd;
    
    [xi, ri] = convex2sphere_world(world, known_world);
    [point_type, ~, idx_sorted, x_dist] = convex_voronoi(x, xi, world, known_world);
    
    % is this a point within an obstacle?
    if (point_type == -1)
        semi_analytic_grad_phi = -1;
        disp( ['Semi-analytic gradient of point within obstacle'...
            'not defined'] );
        return;
    end
    
    idx = idx_sorted(1,1);
    %% (A) does not belong to any weighted Voronoi cell
    if (point_type == 0)
        %disp('Point does not belong to any Voronoi cell.')
        semi_analytic_grad_phi = 2 .*(x - xd);
        return;
    end
    
    %% (B) belongs to a weighted Voronoi cell
    
end
