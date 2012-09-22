%function [] = test_parallelepiped

cls

x0 = origin(3);
L = [1, 5, 10];
pred = define_predicate_array('w', 6);
formula = '!(w1 & w2 & w3 & w4 & w5 & w6)';

halfspaces = create_parallelepiped(x0, L, pred);
obstacles = create_heterogenous_obstacles('halfspaces', halfspaces);
obstacles = add_csg_info(obstacles, formula);

ax = gca;

plot_heterogenous_obstacles(ax, obstacles)

%% navigate
x0 = [-3, -4, 7].';
xd = [3, 6, 5].';
step = 0.3;
maxiter = 100;
k = 6;

qtraj = int_traj_krnf_csg(x0, xd, obstacles, step, maxiter, k);

hold(ax, 'on')
plotmd(ax, qtraj)

plot_scalings(ax, 0)
axis(ax, 'equal')
grid(ax, 'on')
view(ax, 3)
