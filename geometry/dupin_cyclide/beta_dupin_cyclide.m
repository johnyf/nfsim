function [bi, Dbi, D2bi] = beta_dupin_cyclide(q, qc, a, c, m, rot)
%
% There are two definition/computation alternatives
% 1) directly using a center, rotation and parameters
%    this is easier because it is direct
%    Moreover, this involves fewer numerical operations
%    (reduced computational complexity), hence contains less numerical
%    error.
%
% 2) indirectly using the inversion of a torus
%    this requires definition of both the torus and the inversion
%    which is more complicated and demanding

npnt = size(q, 2);

qi = rot.' *bsxfun(@minus, q, qc); % homogenous transform

bi = nan(1, npnt);

x = qi(1, :);
y = qi(2, :);
%z = qi(3, :); % not needed yet

nqi2 = vnorm(qi, 1, 2).^2;

b = sqrt(a^2 -c^2);
bi(1, :) = (nqi2 +b^2 -m^2).^2 -4 *(a *x -c *m).^2 -4 *b^2 *y.^2;
%bi(bi <= 0) = 0; % create an independent function for this

Dbi = 'not yet implemented';
D2bi = 'not yet implemented';
%{
Dbi(:, 1:npnt) = 4 .*[x .*(nqi2 -R^2 -r^2);
                      y .*(nqi2 -R^2 -r^2);
                      z .*(nqi2 +R^2 -r^2) ];
Dbi = rot *Dbi;

a1 = 4 .*(3 .*x.^2 +y.^2 +z.^2 -R^2 -r^2);
a2 = 8 .*x .*y;
a3 = 8 .*x .*z;
a4 = 8 .*x .*y;
a5 = 4 .*(x.^2 +3 .*y.^2 +z.^2 -R^2 -r^2);
a6 = 8 .*y .*z;
a7 = 8 .*x .*z;
a8 = 8 .*y .*z;
a9 = 4 .*(x.^2 +y.^2 +3 .*z.^2 +R^2 -r^2);

D2bi = cell(1, npnt);
for i=1:npnt    
    curD2bi = [a1(1, i), a2(1, i), a3(1, i);
               a4(1, i), a5(1, i), a6(1, i);
               a7(1, i), a8(1, i), a9(1, i) ];
    
    curD2bi = rot *curD2bi *rot.';
    D2bi{1, i} = curD2bi;
end
%}
