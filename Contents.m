% Navigation Function Simulation Toolbox Version 0.1  30-Dec-2010
% Path ->  E:\ioannis\programming\MATLAB\nfsim
%
%
%
%   core_engine\navigate         - navigate.m
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
%   geometry\sphere\plotSphere  - sphere
%
%   geometry\sphere_world\find_ei            - find_ei.m
%   geometry\sphere_world\insert_sphere      - (No help available)
%
%
%   geometry\torus\beta_torus     - (No help available)
%   geometry\torus\nfoldtorus     - illustration of a triple torus
%   geometry\torus\plot_torus     - y, z] = plot_torus(qca, Ra, ra, nc)
%   geometry\torus\torus_phi_test - 
%
%
%   graphics\init_graphics      - init_graphics.m
%   graphics\update_graphics    - update_graphics.m
%
%   graphics\plot_any_world\plot_nf_surf        - plot_nf_surf.m
%
%   graphics\plot_sphere_world\plotS_nf             - plotS_nf.m
%
%
%   gui\creategraphics  - creategraphics.m
%
%   gui\control_panel\auto_k_call           - get data
%   gui\control_panel\field_plot_resolution - get data
%   gui\control_panel\slider_k_call         - get data
%   gui\control_panel\slider_k_callback     - get data
%
%   gui\file\file_open_call        - get data    
%   gui\file\file_restart_call     - (No help available)
%   gui\file\file_save_call        - get data
%
%   gui\general\agent_exists           - (No help available)
%   gui\general\check_navigate_ability - all checked to provide diagnostics
%   gui\general\disable_navigation     - (No help available)
%   gui\general\enable_navigation      - (No help available)
%   gui\general\getgui_objhandles      - (No help available)
%   gui\general\getgui_problem         - (No help available)
%   gui\general\known_world_exists     - (No help available)
%   gui\general\pause_actions          - Resume enable & string
%   gui\general\resume_actions         - Navigate disable
%   gui\general\stop_actions           - Navigate enable
%   gui\general\type_exists            - (No help available)
%   gui\general\update_guidata         - (No help available)
%   gui\general\world_exists           - nothing defined?
%
%   gui\help\help_about_call - (No help available)
%   gui\help\product_help    - (No help available)
%
%
%   gui\init\close_nfsimgui        - 
%   gui\init\init_application_data - (No help available)
%   gui\init\init_figure           - = get(0,'Screensize'); % initially on selected screen->maximized there
%   gui\init\init_menus            - out
%   gui\init\init_panel            - data out
%   gui\init\init_plots            - out
%   gui\init\init_toolbars         - = findall(gcf, 'tag', 'FigureToolBar');
%   gui\init\initgui               - data out
%   gui\init\welcome_msg           - (No help available)
%
%   gui\nf\nav_select_nf_call - data in
%   gui\nf\navigate_call      - get data
%   gui\nf\pause_call         - get data
%   gui\nf\stop_call          - get data
%
%   gui\toolbar\draw_circle_call - get data
%   gui\toolbar\zoom_all_call    - (No help available)
%
%   gui\transform\transform_select_diffeomorphism_call - 'callback', @pp_call);  % Set the callback.
%
%   gui\world\config_agent_call    - data in
%   gui\world\world_boundary_call  - get data
%   gui\world\world_default_call   - data in
%   gui\world\world_dimension_call - get data
%   gui\world\world_load_call      - data in
%   gui\world\world_save_call      - (No help available)
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
%   init\set_known         - = {}; % no details
%
%   navigation_function\iterate_motion_planner - iterate_motion_planner.m
%   navigation_function\navigation_function    - navigation_function.m
%
%   navigation_function\derivatives\analytic_grad - analytic_grad.m
%   navigation_function\derivatives\analytic_hes  - analytic_hes.m
%   navigation_function\derivatives\correct_grad  - correct_grad.m
%   navigation_function\derivatives\numgrad       - numgrad.m
%   navigation_function\derivatives\numgradpt     - numgradpt.m
%   navigation_function\derivatives\numhes        - numhes.m
%   navigation_function\derivatives\numhespt      - numhespt.m
%
%   navigation_function\khatib\check_khatib_args - check_khatib_args.m
%   navigation_function\khatib\khatib            - khatib.m
%   navigation_function\khatib\test_khatib       - test_khatib.m
%
%   navigation_function\krnf\krnf        - krnf.m
%   navigation_function\krnf\krnfs       - krnfs.m
%   navigation_function\krnf\krnfu       - krnfu.m
%   navigation_function\krnf\world2krnfs - world2krnfs.m
%
%   navigation_function\krnf\calc_functions\Dbi2Db           - Dbi2Db.m
%   navigation_function\krnf\calc_functions\Qi_calc          - Qi_calc.m
%   navigation_function\krnf\calc_functions\Qii_calc         - Qii_calc.m
%   navigation_function\krnf\calc_functions\Qji_calc         - Qji_calc.m
%   navigation_function\krnf\calc_functions\bi2b             - bi2b.m
%   navigation_function\krnf\calc_functions\check_krnf_args  - check_krnf_args.m
%   navigation_function\krnf\calc_functions\check_krnfs_args - check_krnfs_args.m
%   navigation_function\krnf\calc_functions\ei01_calc        - ei01_calc.m
%   navigation_function\krnf\calc_functions\ei21_calc        - ei21_calc.m
%   navigation_function\krnf\calc_functions\ei23_calc        - ei23_calc.m
%   navigation_function\krnf\calc_functions\ei3j_calc        - ei3j_calc.m
%   navigation_function\krnf\calc_functions\gamma_d          - gamma_d.m
%   navigation_function\krnf\calc_functions\gdimin_calc      - gdimin_calc.m
%   navigation_function\krnf\calc_functions\maxbji_calc      - maxbji_calc.m
%   navigation_function\krnf\calc_functions\minbji_calc      - minbji_calc.m
%
%   navigation_function\krnf\derivatives\grad_krnf             - grad_krnf.m
%   navigation_function\krnf\derivatives\grad_krnfu            - grad_krnfu.m
%   navigation_function\krnf\derivatives\hes_krnf              - hes_krnf.m
%   navigation_function\krnf\derivatives\normalized_grad_krnfs - normalized_grad_krnfs.m
%
%   navigation_function\krnf\k_update\k_update    - k_update.m
%
%
%   navigation_function\krnf\update_scheme\add_obstacle - add_obstacle.m
%   navigation_function\krnf\update_scheme\krnfs_iter   - krnfs_iter.m
%   navigation_function\krnf\update_scheme\newei        - newei.m
%   navigation_function\krnf\update_scheme\rimon_init   - rimon_init.m
%   navigation_function\krnf\update_scheme\tune_krnfs   - tune_krnfs.m
%   navigation_function\krnf\update_scheme\update_eu    - update_eu.m
%
%   navigation_function\polynomial\diff2s                 - current configuration
%   navigation_function\polynomial\pnfs                   - pnfs.m
%
%
%
%
