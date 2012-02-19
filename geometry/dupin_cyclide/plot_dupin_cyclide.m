function [] = plot_dupin_cyclide(ax, qc, r, q0, r0)
% like the obstacle function (beta_dupin_cyclide), this function also
% has two alternative definitions, either via the inversion of a torus
% or the direct parameterization using the parameters a, c, \mu.

domain = [-pi, pi, -pi, pi];
resolution = [35, 100];

[uv, U, ~] = domain2vec(domain, resolution);

u = uv(1, :);
v = uv(2, :);

q_torus = [ (r +cos(u) ) .*cos(v);...
            (r +cos(u) ) .*sin(v);...
                sin(u) ];
            
q_torus = bsxfun(@plus, q_torus, qc);

q_dupin = geometric_inversion(q_torus, q0, r0);

[X, Y, Z] = vec2meshgrid(q_dupin, U);

surf(ax, X, Y, Z)

function [q] = geometric_inversion(q, q0, r0)
% q0 = inversion sphere center
% r0 = inversion sphere radius

q = bsxfun(@minus, q, q0);
normq = vnorm(q, 1, 2);
unitq = normvec(q, 'p', 2);

q = bsxfun(@rdivide, unitq, normq);
q = r0^2 .*q;
q = bsxfun(@plus, q, q0);
