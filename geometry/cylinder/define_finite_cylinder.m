function [cylinder, planes] = define_finite_cylinder(x1, x2, r, pred)
%DEFINE_FINITE_CYLINDER     Define cylinder and planes for a finite-length
%   cylinder.
%
% See also create_cylinder, create_halfspace.

cylinder_pred = pred(1, 1);
halfspace_pred = pred(1, 2:3);

%% cylinder along x1-x2
xcylinder = x1;
axisv = normvec(x2-x1, 'p', 2);
h = norm(x2-x1, 2);

cylinder = create_cylinder(xcylinder, r, h, axisv, cylinder_pred);

%% planes outward at x1, x2
n1 = x1 -x2; % looking from x2 to x1, so at x1 outward from the linear segment x1, x2
n2 = -n1;

xplanes(:, 1) = x1;
xplanes(:, 2) = x2;

n = [n1, n2];

dom = repmat({r *[-1, 1, -1, 1] }, 1, 2);
planes = create_halfspaces(xplanes, n, dom, halfspace_pred);
