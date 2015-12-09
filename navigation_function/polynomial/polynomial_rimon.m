% File:      nf_polynomial.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2010.09.15
% Language:  MATLAB R2011a
% Purpose:   polynomial navigation function in configuration space
% Copyright: Ioannis Filippidis, 2010-

function [grad, known_world] = polynomial_rimon(agent, world, known_world)
type = 'nf_rimon';

x = agent.xcur;
xd = agent.xd;

[xi, ri] = convex2sphere_world(world, known_world);

[x_end, r_in, r_out, ray, idx] = global_diffeomorphism(x, xi, world, known_world);

%% outside any local diffeo?
if isempty(x_end)
    [grad, ~, ~, known_world] = analytic_gradient(agent, world, known_world, type);
    return
end

%% inside local diffeo
[q, r_new, r, theta] = diffeomorphism(x, xi(:,idx), ri(1,idx), r_in, r_out);
qd = xd; % same destination coordinate
qi = xi; % same obstacle centers

dtheta = 0.01;
theta2 = theta +dtheta;

x2 = r *[cos(theta2); sin(theta2)] +xi(:,idx); % neighbour point for
%numerical tangential derivative of radius for diffeomorphism Jacobian

[x_end2, r_in2, r_out2, ~, ~] = global_diffeomorphism(x2, xi, world, known_world);

if isempty(x_end2)
    r_new2 = norm(x2 -xi(:,idx), 2);
else
    [q2, r_new2, r2, ~] = diffeomorphism(x2, xi(:,idx), ri(1,idx), r_in2, r_out2);
end

dummy_agent = agent;
dummy_agent.xcur = q;
[grad_nf, ~, ~, known_world] = analytic_gradient(dummy_agent, world, known_world, type);

DT = JTi(r, theta, ri(1,idx), r_in, r_out);

DT(1,2) = (r_new2 -r) /dtheta;

R = [ray(1,1), ray(2,1); -ray(2,1), ray(1,1)];
grad = R' *DT' *R *grad_nf;
