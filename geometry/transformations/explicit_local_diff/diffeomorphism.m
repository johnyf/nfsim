function [q, r_new, r, theta] = diffeomorphism(x, xi, ri, r_in, r_out)
%
% input
%   x = point to transform
%   xi = model sphere center (for obstacle i)
%   ri = obstacle polar radius in direction of polar ray (x-x_i)
%        CAUTION: This means 
%   r_in = model sphere radius
%   r_out = local diffeomorphism radius of effect
%
% Reference:
%   Lionis; Papageorgiou; Kyriakopoulos, ICRA 2007
%
% File:      diffeomorphism.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2010.09.15
% Language:  MATLAB R2010b
% Purpose:   Apply diffeomorphism
% Copyright: Ioannis Filippidis, 2010-

%% NOT within an obstacle's weighted Voronoi cell?
if isempty(r_in)
    q = x; % identity map outside weighted Voronoi cell
    return;
end

%% YES within an obstacle's weighted Voronoi cell

%% global cartesian -> real local polar wrt xi
ray = bsxfun(@minus, x, xi);
r = vnorm(ray, 1, 2);
theta = atan2(ray(2, 1), ray(1, 1) );

% find equivalent point in sphere world

%% real local polar coordinates -> sphere world local polar
T = Ti(r, theta, ri, r_in, r_out);

%% sphere world local polar -> sphere world global cartesian
qi = xi; % same obstacle center
r_new = T(1, 1);
q = qi +r_new *ray /r; % sphere world equivalent point
