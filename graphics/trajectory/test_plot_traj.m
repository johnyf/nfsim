function [] = test_plot_traj
% test plot_trajectory
%
% See also plot_trajectory.
%
% File:      test_plot_traj.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.09.20
% Language:  MATLAB R2012a
% Purpose:   test trajectory plotting code for multiple trajectories
% Copyright: Ioannis Filippidis, 2012-

ax = gca;
ndim = 3;
ntraj = 10;
npnt = 1000;

x0 = rand(ndim, ntraj);
xd = rand(ndim, ntraj);

xtraj = cell(1, ntraj);
for i=1:ntraj
    xtraj{1, i} = rand(ndim, npnt);
end

x0str = '$x_0$';
xdstr = '$x_d$';

xtraj_style = {'Color', 'b', 'LineStyle', '--'};
x0_style = {'Color', 'r', 'Marker', 's'};
xd_style = {'Color', 'g', 'Marker', 'o'};

plot_trajectory(ax, x0, xtraj, xd, x0str, xdstr,...
                              xtraj_style, x0_style, xd_style)
plot_scalings(ax, 0)
grid(ax, 'on')
