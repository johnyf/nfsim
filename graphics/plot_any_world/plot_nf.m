% File:      plot_nf.m
% Author:    Ioannis Filippidis, Mechanical Engineer, jfilippidis@gmail.com
% Date:      2010.09.16
% Language:  MATLAB, program version: 7.11 (2010b)
% Purpose:   plot navigation function field in configuration space
% Copyright: Ioannis Filippidis, 2010-

% Example (for agent, world, known_world see initialization functions)
%   limits = [0, 5, 1, 2];
%   n = [50, 20];
%           plot_nf(limits, n, agent, world, known_world,
%                  'Lionis, Papageorgiou & Kyriakopoulos')

function [X, Y, nf_field, fig] = plot_nf(limits, n, agent, world, known_world, type)
% parameters
xmin = limits(1);
xmax = limits(2);

ymin = limits(3);
ymax = limits(4);

nx = n(1);
ny = n(2);

dx = (xmax - xmin) /nx;
dy = (ymax - ymin) /ny;

% caluclate
X = zeros(nx,1);
Y = zeros(ny,1);
nf_field = zeros(ny, nx);
for j=1:nx
    X(j) = xmin+ (j-1)*dx;
    for i=1:ny
        Y(i) = ymin+ (i-1)*dy;
        agent.xcur = [X(j); Y(i)];
        nf_field(i,j) = navigation_function(agent, world, known_world, type);
    end
    disp( ['NF field matrix row: ' num2str(j)] )
end

% show
fig = plot_nf_surf(X, Y, nf_field);
    