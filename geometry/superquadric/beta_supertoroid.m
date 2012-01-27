function [bi, Dbi] = beta_supertoroid(q, qc, a, e, r, rot)
% input
%   q = calculation point
%   qC = center point (origin of translation)
%   a = radii
%     = [3 x 1]
%   e = exponents (epsilons in Barr, Alan H.)
%     = [2 x 1]
%   r = torus major radius
%   R = rotation matrix
%     = [3 x 3]
%
% See also BETA_SUPERTOROIDS, BETA_SUPERELLIPSOIDS, BETA_HETEROGENOUS.

qi = rot.' *bsxfun(@minus, q, qc);

x = qi(1, :);
y = qi(2, :);
z = qi(3, :);

a1 = a(1, 1);
a2 = a(1, 2);
a3 = a(1, 3);

e1 = e(1, 1);
e2 = e(1, 2);
%e3 = e(3, 1);

a4 = r /sqrt(a1^2 +a2^2);

bi = (((x ./a1).^(2 /e2) +(y ./a2).^(2 /e2) ).^(e2 /2) -a4).^(2 /e1) ...
     +(z ./a3).^(2 /e1) -1;

Dbi = [e2 /e1 *(((x /a1).^(2 /e2) +(y /a2).^(2 /e2) ).^(e2 /2) -a4).^(2 /e1 -1)...
      .*((x /a1).^(2 /e2) +(y ./a2).^(2 /e2) ).^(e2 /2 -1)...
      .*(1 /a1)^(2 /e2) .*x.^(2 /e2 -1);
      e2 /e1 *(((x /a1).^(2 /e2) +(y /a2).^(2 /e2) ).^(e2 /2) -a4).^(2 /e1 -1)...
      .*((x /a1).^(2 /e2) +(y ./a2).^(2 /e2) ).^(e2 /2 -1)...
      .*(1 /a2)^(2 /e2) .*y.^(2 /e2 -1);
      (1 /a3)^(2 /e1) .*z.^(2 /e1 -1) ];
Dbi = rot *Dbi;
