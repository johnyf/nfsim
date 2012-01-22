function [tori] = add_torus(torus, tori)
n = size(tori, 1);
n = n +1;

tori(n, 1).qc = torus.qc;
tori(n, 1).r = torus.r;
tori(n, 1).R = torus.R;
tori(n, 1).rot = torus.rot;
