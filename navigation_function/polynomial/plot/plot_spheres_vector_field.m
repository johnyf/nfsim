% File:      plot_spheres_vector_field.m
% Author:    Ioannis Filippidis, Mechanical Engineer, jfilippidis@gmail.com
% Date:      2010.10.03
% Language:  MATLAB, program version: 7.11 (2010b)
% Purpose:   plot sphere world obstacles and navigation function vector field
% Copyright: Ioannis Filippidis, 2010-

plotS_nf_and_contour(agent, world, known_world,...
    'nf_polynomial')

[xi, ri] = convex2sphere_world(world, known_world);
plotS_sphere_effect_zones([0; 0], xi, ri);
plot_circles_polygons_rays(agent, world, known_world);
