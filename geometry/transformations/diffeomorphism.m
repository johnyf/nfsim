% File:      diffeomorphism.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2010.09.15
% Language:  MATLAB R2010b
% Purpose:   Apply diffeomorphism
% Copyright: Ioannis Filippidis, 2010-

function [q, r_new, r, theta] = diffeomorphism(x, xi, ri, r_in, r_out)
%% NOT within an obstacle's weighted Voronoi cell?
if isempty(r_in)
    q = x; % identity map outside weighted Voronoi cell
    return;
end

%% YES within an obstacle's weighted Voronoi cell

% Configuration space
%
% global cartesian ->
% real local polar
% wrt xi (center of sphere representing obstacle i)
ray = x - xi;
r = norm(ray, 2);
theta = atan2(ray(2,1), ray(1,1));

% find equivalent point in sphere world
%
% real local polar coordinates ->
% sphere world local polar
T = Ti(r, theta, ri, r_in, r_out);

% sphere world local polar ->
% sphere world global cartesian
qi = xi; % same obstacle center
r_new = T(1,1);
q = qi + r_new *ray /r; % sphere world equivalent point
