% experiment with geometric inversion of ellipsoids
%
% 2013.01.23 Copyright Ioannis Filippidis

cla

% ellipsoid def
r = [3, 0.3, 0.5].';

% parametric ellipsoid surf
dom = [0, 2*pi, 0, pi];
res = [55, 70];
u = dom2vec(dom, res);
q = parametric_ellipsoid(u, origin(3), eye(3), r);

% inversion sphere def
q0 = origin(3);
r0 = 1;
%inner_product_ellipsoid_radii = [1, 3, 10];
%r0 = radii2ellipsoid(inner_product_ellipsoid_radii);

[qi, Du] = geometric_inversion(q, q0, r0);

w = jacobian_mapping_vectors(Du, q);

ax = gca;
    hold(ax, 'on')
    vsurf(ax, q, 'r', res)
    vsurf(ax, qi, 'g', res)
    quivermd(ax, qi, w)
plotidy
axis(ax, 'equal')
