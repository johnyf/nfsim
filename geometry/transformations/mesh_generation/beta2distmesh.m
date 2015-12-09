function [b] = beta2distmesh(p, obstacles)
q = p.';

obstacles = obstacles(1);

bi = beta_heterogenous(q, obstacles);
bi2 = bounding_box(q);
b = bi2b([bi; bi2] );

b = -b;
b = b.';

function [bi2] = bounding_box(q)
bi2 = 20 -vnorm(q).^2;
