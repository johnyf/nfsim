function [bi, Dbi, D2bi] = beta_cylinder(q, qc, n, r)

npnt = size(q, 2);

q_qc = bsxfun(@minus, q, qc);
norm_qaxial = dot(q_qc, repmat(n, 1, npnt) );
qaxial = n *norm_qaxial;
qnormal = q_qc -qaxial;

R = vnorm(qnormal, 1, 2);
bi = R.^2 -r^2;
Dbi = 2 *qnormal;
D2bi = 2 *[1, 0, 0; 0, 1, 0; 0, 0, 0];
D2bi = {D2bi};
D2bi = repmat(D2bi, 1, npnt);
