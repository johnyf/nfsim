% File:      draw_sensing_set.m
% Author:    Ioannis Filippidis, Mechanical Engineer, jfilippidis@gmail.com
% Date:      2010.09.15
% Language:  MATLAB, program version: 7.11 (2010b)
% Purpose:   take sensing set definition
%               plot sensing set & sensing rays
% Copyright: Ioannis Filippidis, 2010-

function draw_sensing_set(agent)
hold on

% sensing disk boundary points
t = 2*pi *linspace(0,1,1000);
xsens = agent.Rs * [sin(t); cos(t)];
xsens = xsens + agent.xcur * ones(1, size(xsens,2));

% sensing disk boundary
plot(xsens(1,:), xsens(2,:), 'r-')

% sensing radii
plot([agent.xcur(1,1)*ones(1,1000); xsens(1,:)], [agent.xcur(2,1)*ones(1,1000); xsens(2,:)], 'r-')

axis equal
hold off
