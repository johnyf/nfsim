% Navigation Function Simulation Toolbox Version 0.5  22-Dec-2013
% Path ->  /Users/ifilippi/Dropbox/ioannis/programming/matlab/nfsim
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%   core_engine/int_traj_krf_csg       - Integrate KRF trajectory for CSG obstacles.
%   core_engine/multi_int_traj_krf_csg - Simultaneously integrate multiple KRF
%   core_engine/navigate               - navigate.m
%   core_engine/old_world_update       - old_world_update.m
%   core_engine/qtraj_mat2cell         - 3d matrix of trajectories to row cell array of 2d matrices
%   core_engine/reached_goal           - loop termination criteria checking
%   core_engine/sensing_set            - sensing_set.m
%   core_engine/sensing_setS           - sensing_setS.m
%   core_engine/world_update           - world_update.m
%
%   core_engine/init/init_agent        - = init_agent() % default agent
%   core_engine/init/init_bezier_world - init_bezier_world.m
%   core_engine/init/init_known_world  - init_known_world.m
%   core_engine/init/init_sphere_world - init_sphere_world.m
%   core_engine/init/set_known         - set_known.m
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%   factory/generate_doc/doc_nfsim - Navigation Function Simulation Toolbox documentation
%
%   factory/latex_listing/nfsim_listing - listing for inclusion with listings package
%
%   factory/manual_imgs/simple_ellipse_world - = [1, 11, 1, 11];
%
%   factory/zip/nfsim_distro_dirs - the level-1 subdirectories of nfsim, excluding development ones,
%   factory/zip/zip_nfsim         - list all files of nfsim toolbox,
%
%   geometry/add_csg_info                  - Add Constructive Solid Geometry info to obstacles.
%   geometry/beta_heterogenous             - Implicit functions and derivatives for mixed obstacles.
%   geometry/copy_obstace                  - copy obstacle between obstacle structure arrays
%   geometry/create_heterogenous_obstacles - asseble heterogenous obstacles struct
%   geometry/define_obstacle_types         - Names of obstacle types.
%   geometry/find_inward_obstacles         - Indices of inwards ellipsoids.
%   geometry/get_obstacle_predicates       - Get predicate names of obstacles.
%   geometry/plot_heterogenous_obstacles   - Plot mixed obstacle types.
%
%   geometry/bezier/bezier_draw                  - 
%   geometry/bezier/bezier_points                - bezier_points.m
%   geometry/bezier/control_points2bezier_coef   - control_points2bezier_coef.m
%   geometry/bezier/m_calc                       - m_calc.m
%   geometry/bezier/plot_visible_bezier_obstacle - index] = ismember(i, id);
%
%   geometry/convex_world/world2spheres              - world data structure to sphere world, including agent state
%
%   geometry/csg/binary_operator        - Binary propositional operators used in CSG.
%   geometry/csg/csg                    - Implicit Constructive Solid Geometry.
%   geometry/csg/define_predicate_array - 
%   geometry/csg/formula2parse_tree     - Convert formula to parse tree.
%   geometry/csg/idx2str_tree           - (No help available)
%   geometry/csg/insert_values2tree     - insert_values2tree.m
%   geometry/csg/parse2str_tree         - (No help available)
%   geometry/csg/predicates2indices     - Convert predicate names to indices.
%   geometry/csg/unary_operator         - Unary propositional operator used in CSG.
%
%   geometry/cylinder/beta_cylinder          - Single cylinder obstacle function and derivatives.
%   geometry/cylinder/beta_cylinders         - Obstacle and derivatives for multiple cylinders.
%   geometry/cylinder/create_cylinder        - Initialize cylinder struct.
%   geometry/cylinder/create_cylinders       - Initialize multiple cylinder structures.
%   geometry/cylinder/define_finite_cylinder - Define cylinder and planes for a finite-length
%   geometry/cylinder/plot_cylinder          - Plot a cylinder.
%   geometry/cylinder/plot_cylinders         - Plot multiple cylinders.
%
%   geometry/dupin_cyclide/beta_supercyclide                  - Implicit obstacle function for Dupin cyclide.
%   geometry/dupin_cyclide/example_dupin_cyclide              - Plot a sample Dupin cyclide.
%   geometry/dupin_cyclide/example_supercyclide               - Plot a sample Supercyclide.
%   geometry/dupin_cyclide/plot_dupin_cyclide_using_inversion - Plot Dupin cyclide.
%   geometry/dupin_cyclide/plot_elliptic_supercyclide         - Plot elliptic supercyclide.
%
%   geometry/ellipse/parametric_ellipse       - Parametric ellipse equation.
%   geometry/ellipse/polar_parametric_ellipse - Parametric ellipse equation in polar coordinates.
%
%   geometry/ellipsoid/beta_ellipsoid       - obstacle function for single ellipsoid.
%   geometry/ellipsoid/beta_ellipsoids      - obstacle function for multiple ellipsoids.
%   geometry/ellipsoid/check_ellipsoid      - if matrix A defines a quadratic form (whose level set at value 1
%   geometry/ellipsoid/create_ellipsoid     - Initialize ellipsoid structure.
%   geometry/ellipsoid/create_ellipsoids    - Initializes struct array of ellipsoids.
%   geometry/ellipsoid/grad_krf_ellipsoid   - for a set of ellipse obstacles
%   geometry/ellipsoid/parametric_ellipsoid - Parametric equation of ellipsoid.
%   geometry/ellipsoid/plot_ellipsoid       - Ellipsoid or ellipse plot.
%   geometry/ellipsoid/plot_ellipsoids      - multiple ellipsoids.
%   geometry/ellipsoid/radii2ellipsoid      - Convert diagonals to ellipsoid symmetric matrix
%
%   geometry/halfspace/beta_halfspace    - Dbi, D2bi] = beta_halfspace(x, xp, n)
%   geometry/halfspace/beta_halfspaces   - Obstacle functions of half-spaces.
%   geometry/halfspace/create_halfspace  - Initialize halfspace structure.
%   geometry/halfspace/create_halfspaces - Initialize multiple halfspace structures.
%   geometry/halfspace/plot_halfspace    - Plot hyperplane (finite rectangular region).
%   geometry/halfspace/plot_halfspaces   - Plot multiple hyperplanes.
%
%   geometry/hyperboloid/beta_hyperboloids  - also BETA_HYPERBOLOID, BETA_HETEROGENOUS, BIDBID2BI2BDBD2B
%   geometry/hyperboloid/beta_hyperboloids  - (No help available)
%   geometry/hyperboloid/img_on_hyperboloid - img_on_hyperboloid.m
%   geometry/hyperboloid/plot_hyperboloid   - Plot one-sheet hyperboloid.
%   geometry/hyperboloid/plot_hyperboloids  - plot one-sheet hyperboloids
%
%
%   geometry/implicit_diff_geometry/focal_example/ellipsoid_focal_surface - also TORUS_FOCAL_SURFACE, PLOT_BETA_FOCAL_SURFACES.
%   geometry/implicit_diff_geometry/focal_example/torus_focal_surface     - 
%
%   geometry/implicit_diff_geometry/focal_surfaces/implicit_focal_surface       - Focal surface sheet points of implicit surface.
%   geometry/implicit_diff_geometry/focal_surfaces/plot_beta_focal_surface      - 
%   geometry/implicit_diff_geometry/focal_surfaces/plot_beta_focal_surfaces     - 
%   geometry/implicit_diff_geometry/focal_surfaces/plot_implicit_focal_surface  - Plot focal surface of implicit surface.
%   geometry/implicit_diff_geometry/focal_surfaces/plot_implicit_focal_surfaces - Plot obstacle focal surface sheets.
%
%   geometry/implicit_diff_geometry/principal_normal_curvature/domain2b_normal_curvature                 - Plot curvature radius for 1D level sets.
%   geometry/implicit_diff_geometry/principal_normal_curvature/implicit_principal_curvature_spheres      - Principal curvature spheres.
%   geometry/implicit_diff_geometry/principal_normal_curvature/implicit_principal_normal_curvatures      - Principal curvatures.
%   geometry/implicit_diff_geometry/principal_normal_curvature/plot_beta_principal_curvature_circles     - Plot obstacle principal curvature
%   geometry/implicit_diff_geometry/principal_normal_curvature/plot_beta_principal_curvature_spheres     - Plot obstacle principal curvature
%   geometry/implicit_diff_geometry/principal_normal_curvature/plot_implicit_principal_curvature_circles - Plot principal curvature
%   geometry/implicit_diff_geometry/principal_normal_curvature/plot_implicit_principal_curvature_spheres - Plot principal curvature
%
%   geometry/lemniscate_booth/beta_booth_lemniscates        - 
%   geometry/lemniscate_booth/beta_inward_booth_lemniscates - 
%   geometry/lemniscate_booth/beta_lemniscate_booth         - Booth leminiscate obstacle function.
%   geometry/lemniscate_booth/beta_lemniscate_booth2        - Booth leminiscate obstacle function.
%   geometry/lemniscate_booth/create_booth_lemniscates      - (No help available)
%   geometry/lemniscate_booth/parametric_lemniscate_booth   - Parametric Booth leminiscate curve.
%   geometry/lemniscate_booth/parametric_lemniscate_booth2  - Parametric Booth leminiscate curve.
%   geometry/lemniscate_booth/plot_booth_lemniscates        - 
%   geometry/lemniscate_booth/plot_inward_booth_lemniscates - 
%   geometry/lemniscate_booth/plot_lemniscate_booth         - Booth leminiscate curve and plot.
%   geometry/lemniscate_booth/plot_lemniscate_booth2        - Booth leminiscate curve and plot.
%   geometry/lemniscate_booth/test_lemniscate_booth         - Testing plots for Booth Leminiscate.
%
%   geometry/mobius_band/mobius_band - mobius_band.m
%
%   geometry/not_ellipsoid/beta_not_ellipsoid    - Inwardly oriented quadric, i.e., for 0th obstacle.
%   geometry/not_ellipsoid/beta_not_ellipsoids   - 
%   geometry/not_ellipsoid/create_not_ellipsoid  - Define an inward ellipsoid.
%   geometry/not_ellipsoid/create_not_ellipsoids - create array of inward quadric structures.
%   geometry/not_ellipsoid/plot_not_ellipsoids   - 
%
%   geometry/parallelepiped/create_parallelepiped - 
%   geometry/parallelepiped/create_rectangle      - (No help available)
%
%   geometry/rvachev/assign_rvachev_operation      - Process Rvachev options.
%   geometry/rvachev/grad_rvachev                  - Gradient of Rvachev function.
%   geometry/rvachev/hessian_rvachev               - Hessian matrix of Rvachev function.
%   geometry/rvachev/nf_rvachev                    - nf_rvachev.m
%   geometry/rvachev/recursive_grad_rvachev        - Gradient of Boolean operation on two predicates.
%   geometry/rvachev/recursive_grad_rvachev_row    - Gradient of Boolean operation on two predicates.
%   geometry/rvachev/recursive_hessian_rvachev     - Gradient of Boolean operation on two predicates.
%   geometry/rvachev/recursive_hessian_rvachev_row - Gradient of Boolean operation on two predicates.
%   geometry/rvachev/recursive_rvachev             - Recursive Rvachev operation along rows.
%   geometry/rvachev/recursive_rvachev_bdd         - Tree Rvachev operation along rows.
%   geometry/rvachev/rvachev                       - Boolean operation on two Rvachev functions
%   geometry/rvachev/rvachevn                      - N-ary Rvachev operation.
%
%   geometry/sphere/beta_sphere       - spheres?
%   geometry/sphere/beta_spheres_fast - \nabla\beta, D^2\beta
%   geometry/sphere/plotSphere        - a 2-sphere
%   geometry/sphere/plot_circle       - = [qc1(:,1), qc2(:,1), ..., qc(:,n)]; % circle centers
%   geometry/sphere/plot_sphere       - Plot sphere or circle (depends on dim).
%   geometry/sphere/plot_spheres      - (No help available)
%   geometry/sphere/unitcircle        - = unitcircle(n) % X = [2 x n]
%
%   geometry/sphere_world/find_ei            - find_ei.m
%   geometry/sphere_world/insert_sphere      - (No help available)
%   geometry/sphere_world/xcr2qcrr0          - (No help available)
%
%   geometry/superquadric/beta_superellipsoid       - 
%   geometry/superquadric/beta_superellipsoids      - 
%   geometry/superquadric/beta_supertoroid          - 
%   geometry/superquadric/beta_supertoroids         - BETA_HETEROGENOUS, BIDBID2BI2BDBD2B.
%   geometry/superquadric/parametric_superellipsoid - 
%   geometry/superquadric/plot_superellipsoid       - 
%   geometry/superquadric/plot_supertoroid          - = axes handle
%
%   geometry/torus/beta_tori                  - multiple tori implicit functions and gradients.
%   geometry/torus/beta_torus                 - Torus implicit function, gradient and Hessian matrix.
%   geometry/torus/create_tori                - = [];
%   geometry/torus/create_torus               - initialize 2-torus structure
%   geometry/torus/parametric_torus           - Generate a torus.
%   geometry/torus/parametric_torus2          - Generate a torus.
%   geometry/torus/plot_tori                  - Plot multiple tori.
%   geometry/torus/plot_torus                 - Plot a torus.
%   geometry/torus/torus_homogenous_transform - torus_homogenous_transform.m
%
%   geometry/transformations/local_star_world_diffeo_infty       - Local implicit star world diffeomorphism.
%   geometry/transformations/sample_ellipse_world_2_sphere_world - Sample global implicit diffeomorphism.
%   geometry/transformations/test_local_explicit_diffeo_gluing   - x, calc_g(x) )
%
%
%   geometry/transformations/codomain_diff/sigma_switch/plot_sigma_switch - 
%   geometry/transformations/codomain_diff/sigma_switch/sigma_fading      - to be used before combination (e.g. with product or
%   geometry/transformations/codomain_diff/sigma_switch/sigma_intervals   - 
%   geometry/transformations/codomain_diff/sigma_switch/sigma_switch      - Twice continuously differentiable switch function.
%
%   geometry/transformations/codomain_diff/smooth_switch/inf_length_switch        - switch function from 0 at x=0 to 1 at +\infty
%   geometry/transformations/codomain_diff/smooth_switch/smooth_switch            - Smooth switch function with compact support.
%   geometry/transformations/codomain_diff/smooth_switch/smooth_switch_normalized - 
%   geometry/transformations/codomain_diff/smooth_switch/test_smooth_switch       - Testing the smooth switch function.
%
%   geometry/transformations/domain_diff_derivatives/jacobian_mapping_vectors - 
%
%   geometry/transformations/domain_diff_derivatives/pol_cart_derivative_transforms/pol2cart_jacobian - pol2cart_jacobian.m
%
%   geometry/transformations/explicit_local_diff/JTi                        - 
%   geometry/transformations/explicit_local_diff/Ti                         - 
%   geometry/transformations/explicit_local_diff/local_explicit_diffeo      - 
%   geometry/transformations/explicit_local_diff/test_local_explicit_diffeo - Testing local explicit diffeomorphism.
%
%   geometry/transformations/explicit_local_diff/plots/plot_T1                            - 
%   geometry/transformations/explicit_local_diff/plots/plot_bi                            - when it is a diffeomorphism and when it is not.
%   geometry/transformations/explicit_local_diff/plots/test_plot_bi_explicit_local_diffeo - 
%
%   geometry/transformations/geometric_inversion/circle_geometric_inverse      - Inverse of a circle.
%   geometry/transformations/geometric_inversion/geometric_inversion           - Invert wrt sphere.
%   geometry/transformations/geometric_inversion/ginv                          - Wrapper for geometric_inversion. See that for help
%   geometry/transformations/geometric_inversion/test_circle_geometric_inverse - Copyright Ioannis Filippidis
%
%   geometry/transformations/geometric_inversion/inversion-animation/inversionAnimation     - [domain, curves]):
%   geometry/transformations/geometric_inversion/inversion-animation/invertATicTacToeBoard  - 
%   geometry/transformations/geometric_inversion/inversion-animation/rectToPolar            - (No help available)
%
%
%   geometry/transformations/implicit_global_diff/analytic_switch            - Smooth switch from one obstacle to another.
%   geometry/transformations/implicit_global_diff/point_world_transformation - point_world_transformation.m
%   geometry/transformations/implicit_global_diff/star_deforming_factor      - Deformation scaling factor along ray.
%   geometry/transformations/implicit_global_diff/star_world_transformation  - Map star world to sphere world.
%
%   geometry/transformations/implicit_local_diff/local_star_world_diffeo - Local implicit star world diffeomorphism.
%
%   geometry/transformations/mesh_generation/beta2distmesh - (No help available)
%
%   geometry/transformations/plot_mapping/clean_inside_obstacle      - 
%   geometry/transformations/plot_mapping/plot_mapping               - Plot a diffeomorphism on XY plane.
%   geometry/transformations/plot_mapping/plot_mapping_square2square - plot_mapping_square2square.m
%   geometry/transformations/plot_mapping/triplot_mapping            - Plot a diffeomorphism on a triangulated 2d mesh.
%
%   geometry/twin_circles/beta_twin_circles       - also PLOT_TWIN_CIRCLES, PARAMETRIC_TWIN_CIRCLES, TEST_TWIN_CIRCLES.
%   geometry/twin_circles/parametric_twin_circles - Parametric curve of twin circle union.
%   geometry/twin_circles/plot_twin_circles       - also BETA_TWIN_CIRCLES, PARAMETRIC_TWIN_CIRCLES, TEST_TWIN_CIRCLES.
%   geometry/twin_circles/test_twin_circles       - 
%
%   geometry/voronoi/convex_voronoi                    - convex_voronoi.m
%
%
%   graphics/plot_any_world/domain2beta         - obstacle function, derivatives in 2/3D rectangular domain
%   graphics/plot_any_world/domain2beta_rvachev - Obstacle function and derivatives in 2/3D domain
%   graphics/plot_any_world/domain2grad_krf     - Koditschek-Rimon gradient over 2D rectangular domain
%   graphics/plot_any_world/domain2krf          - Compute Kodistchek-Rimon  in rectangular domain
%   graphics/plot_any_world/krf2gradfield       - scalar field negated gradient field
%   graphics/plot_any_world/krf2surfc3          - KRF surface and level sets over 2D domain
%   graphics/plot_any_world/quiver_krf          - plot KRNF negated gradient field over 2D rectangular domain
%   graphics/plot_any_world/streakarrow_krf     - plot KRF negated gradient field over 2D rectangle.
%   graphics/plot_any_world/surfc3_krf          - plot KRNF surface over 2D rectangular domain
%
%   graphics/plot_sphere_world/domain2grad_krfs - calculate KRFS gradient field over 2D rectangular domain
%   graphics/plot_sphere_world/domain2krfs      - calculate KRFS over 2D rectangular domain
%   graphics/plot_sphere_world/quiver_krfs      - plot KRNFS negated gradient field over 2D rectangular domain
%   graphics/plot_sphere_world/surfc3_krfs      - Plot KRFS surface over 2D rectangular domain
%
%   graphics/sensing/draw_rays        - plot rays from X to endpoints of XB
%   graphics/sensing/draw_sensing_set - plot sensing circle with its radii
%
%   graphics/trajectory/plot_path       - Plot trajectory on function surface.
%   graphics/trajectory/plot_trajectory - Plot trajectory, initial condition and
%   graphics/trajectory/test_plot_traj  - plot_trajectory
%
%   gui/creategraphics  - creategraphics.m
%
%   gui/control_panel/auto_k_call           - get data
%   gui/control_panel/field_plot_resolution - get data
%   gui/control_panel/slider_k_call         - get data
%   gui/control_panel/slider_k_callback     - get data
%
%   gui/file/file_open_call        - get data    
%   gui/file/file_restart_call     - (No help available)
%   gui/file/file_save_call        - get data
%
%   gui/general/agent_exists           - (No help available)
%   gui/general/check_navigate_ability - all checked to provide diagnostics
%   gui/general/disable_navigation     - (No help available)
%   gui/general/enable_navigation      - (No help available)
%   gui/general/getgui_objhandles      - (No help available)
%   gui/general/getgui_problem         - (No help available)
%   gui/general/known_world_exists     - (No help available)
%   gui/general/pause_actions          - Resume enable & string
%   gui/general/resume_actions         - Navigate disable
%   gui/general/stop_actions           - Navigate enable
%   gui/general/type_exists            - (No help available)
%   gui/general/update_guidata         - (No help available)
%   gui/general/world_exists           - nothing defined?
%
%   gui/help/help_about_call - (No help available)
%   gui/help/product_help    - (No help available)
%
%
%   gui/init/close_nfsimgui        - 
%   gui/init/init_application_data - (No help available)
%   gui/init/init_figure           - = get(0,'Screensize'); % initially on selected screen->maximized there
%   gui/init/init_graphics         - init_graphics.m
%   gui/init/init_menus            - out
%   gui/init/init_panel            - data out
%   gui/init/init_plots            - out
%   gui/init/init_toolbars         - = findall(gcf, 'tag', 'FigureToolBar');
%   gui/init/initgui               - data out
%   gui/init/welcome_msg           - (No help available)
%
%   gui/nf/nav_select_nf_call - data in
%   gui/nf/navigate_call      - get data
%   gui/nf/pause_call         - get data
%   gui/nf/stop_call          - get data
%
%   gui/plot/update_graphics - update_graphics.m
%   gui/plot/update_nf_field - update_nf_field.m
%
%   gui/toolbar/draw_circle_call - get data
%   gui/toolbar/zoom_all_call    - (No help available)
%
%   gui/transform/transform_select_diffeomorphism_call - 'callback', @pp_call);  % Set the callback.
%
%   gui/world/config_agent_call    - data in
%   gui/world/world_boundary_call  - get data
%   gui/world/world_default_call   - data in
%   gui/world/world_dimension_call - get data
%   gui/world/world_load_call      - data in
%   gui/world/world_save_call      - (No help available)
%
%   navigation_function/iterate_motion_planner - iterate_motion_planner.m
%   navigation_function/navigation_function    - navigation_function.m
%
%   navigation_function/derivatives/analytic_grad - analytic_grad.m
%   navigation_function/derivatives/analytic_hes  - analytic_hes.m
%   navigation_function/derivatives/correct_grad  - correct_grad.m
%   navigation_function/derivatives/hes2mat3d     - cell array (row) of matrices to a 3-dimensional "stack" of them
%   navigation_function/derivatives/numgrad       - Numerical gradient.
%   navigation_function/derivatives/numgradpt     - Numerical gradient points.
%   navigation_function/derivatives/numhes        - numhes.m
%   navigation_function/derivatives/numhespt      - numhespt.m
%
%   navigation_function/khatib/Dbi2Db_sum               - gradient Db of sum b of obstacle functions bi
%   navigation_function/khatib/check_khatib_args        - check_khatib_args.m
%   navigation_function/khatib/grad_khatib              - (No help available)
%   navigation_function/khatib/integrate_khatib         - (No help available)
%   navigation_function/khatib/khatib                   - Potential field function proposed by Khatib
%   navigation_function/khatib/khatib_testing_obstacles - (No help available)
%   navigation_function/khatib/test_khatib              - test_khatib.m
%
%
%   navigation_function/krnf/calc_functions/Qi_calc         - Qi_calc.m
%   navigation_function/krnf/calc_functions/Qii_calc        - Qii_calc.m
%   navigation_function/krnf/calc_functions/Qji_calc        - Qji_calc.m
%   navigation_function/krnf/calc_functions/check_krf_args  - test general world arguments
%   navigation_function/krnf/calc_functions/check_krfs_args - test sphere world arguments
%   navigation_function/krnf/calc_functions/ei01_calc       - ei01_calc.m
%   navigation_function/krnf/calc_functions/ei21_calc       - ei21_calc.m
%   navigation_function/krnf/calc_functions/ei23_calc       - ei23_calc.m
%   navigation_function/krnf/calc_functions/ei3j_calc       - ei3j_calc.m
%   navigation_function/krnf/calc_functions/maxbji_calc     - maxbji_calc.m
%   navigation_function/krnf/calc_functions/minbji_calc     - minbji_calc.m
%
%   navigation_function/krnf/derivatives/bspline_hessian_matrix - 
%   navigation_function/krnf/derivatives/grad_free              - Only squashed paraboloid destination attraction,
%   navigation_function/krnf/derivatives/grad_krf               - Koditschek-Rimon function gradient (analytical)
%   navigation_function/krnf/derivatives/grad_krfu              - Un-squashed Koditschek-Rimon function gradient.
%   navigation_function/krnf/derivatives/grad_krfu_k1k2         - 
%   navigation_function/krnf/derivatives/grad_spline_krf        - of Koditschek-Rimon function for B-spline obstacle function
%   navigation_function/krnf/derivatives/grad_spline_krfu       - of Koditschek-Rimon unsquashed function for B-spline obstacle
%   navigation_function/krnf/derivatives/hes_krf                - Koditschek-Rimon function Hessian matrix.
%   navigation_function/krnf/derivatives/hes_krfu               - Un-squashed Koditschek-Rimon function Hessian matrix.
%   navigation_function/krnf/derivatives/hes_spline_krf         - Hessian matrix of KRF with spline obstacle
%   navigation_function/krnf/derivatives/hes_spline_krfu        - yet implemented, please use hes_spline_krf for now instead
%   navigation_function/krnf/derivatives/normalized_grad_krfs   - analytical formula for normalized gradient in
%
%   navigation_function/krnf/field/krf         - Koditschek-Rimon Navigation Function for any implicit world.
%   navigation_function/krnf/field/krfs        - Koditschek-Rimon function optimized for sphere worlds.
%   navigation_function/krnf/field/krfu        - Un-squashed Koditschek-Rimon function.
%   navigation_function/krnf/field/spline_krf  - Koditschek-Rimon function with B-spline obstacle function.
%   navigation_function/krnf/field/spline_krfu - Unsquashed Koditschek-Rimon function with B-spline obstacle
%
%   navigation_function/krnf/gammad/check_qqd                  - destination dimension
%   navigation_function/krnf/gammad/dipole_gamma_d             - 
%   navigation_function/krnf/gammad/gamma_d                    - 
%   navigation_function/krnf/gammad/gdimin_calc                - gdimin_calc.m
%   navigation_function/krnf/gammad/limit_cycle_potential      - Melo, Geometric Theory of Dynamical Systems, pp. 13-15 (Example 3)
%   navigation_function/krnf/gammad/plot_limit_cycle_potential - plot_limit_cycle_potential.m
%   navigation_function/krnf/gammad/r_gamma_d                  - 
%
%   navigation_function/krnf/gammad/general_gd_plot/plot_general_gd_components - plot_general_gd_components.m
%
%   navigation_function/krnf/k_update/k_update    - k_update.m
%
%
%   navigation_function/krnf/obstacles/D2bi2D2b                 - Hessian matrix for product of obstacle functions
%   navigation_function/krnf/obstacles/D2bi2D2b_rvachev         - Rvachev operation between Hessian matrices.
%   navigation_function/krnf/obstacles/Dbi2Db                   - Gradient Db of product b of obstacle functions bi.
%   navigation_function/krnf/obstacles/Dbi2Db_rvachev           - Gradient Db of Rvachev function of obstacles bi.
%   navigation_function/krnf/obstacles/beta_csg                 - Obstacle function of model defined using constructive solid
%   navigation_function/krnf/obstacles/bi2b                     - multiply multiple obstacle functions
%   navigation_function/krnf/obstacles/bi2b_rvachev             - Recursive rvachev conjunction of obstacles.
%   navigation_function/krnf/obstacles/biDbiD2bi2bDbD2b         - multiple obstacle function values to their product
%   navigation_function/krnf/obstacles/biDbiD2bi2bDbD2b_csg     - Constructive Solid Geometry between obstacles
%   navigation_function/krnf/obstacles/biDbiD2bi2bDbD2b_rvachev - Rvachev function and derivatives for obstacles.
%   navigation_function/krnf/obstacles/check_biDbiD2bi          - multiple obstacles ?
%   navigation_function/krnf/obstacles/scale_fDfD2f             - (No help available)
%
%   navigation_function/krnf/update_scheme/add_obstacle - NEWR, QCOLD, ROLD, Q, QD, KNOWN) update k for newly
%   navigation_function/krnf/update_scheme/krnfs_iter   - krnfs_iter.m
%   navigation_function/krnf/update_scheme/newei        - newei.m
%   navigation_function/krnf/update_scheme/rimon_init   - rimon_init.m
%   navigation_function/krnf/update_scheme/tune_krnfs   - tune_krnfs.m
%   navigation_function/krnf/update_scheme/update_eu    - update_eu.m
%
%   navigation_function/makrnf/test_plot_krnfd - (No help available)
%
%   navigation_function/makrnf/calc_functions/Gi                    - = current agent configuration [#dim x 1]
%   navigation_function/makrnf/calc_functions/Gi_follower           - 
%   navigation_function/makrnf/calc_functions/calc_Gi               - all levels
%   navigation_function/makrnf/calc_functions/check_krfd_parameters - (No help available)
%
%   navigation_function/makrnf/derivatives/numgrad_makrfsd  - numerical gradient for 1 agent
%   navigation_function/makrnf/derivatives/numgrad_makrfsdc - numerical gradient for 1 agent
%
%   navigation_function/makrnf/field/makrfsd  - multi-agent Koditschek-Rimon function for spherical agents
%   navigation_function/makrnf/field/makrfsdc - multi-agent Koditschek-Rimon function for spherical agents 
%
%   navigation_function/polynomial/diff2s                 - current configuration
%   navigation_function/polynomial/pnfs                   - pnfs.m
%
%
%
