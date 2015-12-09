function [bi, Dbi] = beta_superellipsoid(q, qc, a, e, rot)
% input
%   q = calculation point
%   qC = center point (origin of translation)
%   a = radii
%     = [3 x 1]
%   e = exponents (epsilons in Barr, Alan H.)
%     = [2 x 1]
%   rot = rotation matrix
%       = [3 x 3]
%
% See also BETA_SUPERELLIPSOIDS.

qi = rot.' *bsxfun(@minus, q, qc);

x = qi(1, :);
y = qi(2, :);
z = qi(3, :);

a1 = a(1, 1);
a2 = a(2, 1);
a3 = a(3, 1);

e1 = e(1, 1);
e2 = e(2, 1);
%e3 = e(3, 1);

bi = ((x /a1).^(2 /e2) +(y /a2).^(2 /e2) ).^(e2 /e1)...
     +(z /a3).^(2 /e1) -1;
Dbi = [2 /e1 *((x /a1).^(2 /e2) +(y /a2).^(2 /e2) ).^(e2 /e1 -1)...
       .*(1 /a1)^(2 /e2) .*x.^(2 /e2 -1);
       2 /e1 *((x /a1).^(2 /e2) +(y /a2).^(2 /e2) ).^(e2 /e1 -1)...
       .*(1 /a2)^(2 /e2) .*y.^(2 /e2 -1);
       (1 /a3)^(2 /e1) .*z.^(2 /e1 -1) ];
Dbi = rot *Dbi;
