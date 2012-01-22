function [quadrics] = add_quadric(quadric, quadrics)
n = size(quadrics, 1);
n = n +1;

quadrics(n, 1).qc = quadric.qc;
quadrics(n, 1).A = quadric.A;
quadrics(n, 1).rot = quadric.rot;
