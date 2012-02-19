function [qc, R, V] = implicit_principal_curvature_spheres(x, grad, Hessian)
%
% See also PLOT_IMPLICIT_PRINCIPAL_CURVATURE_SPHERES,
%          PLOT_IMPLICIT_PRINCIPAL_CURVATURE_CIRCLES,
%               IMPLICIT_PRINCIPAL_NORMAL_CURVATURES.
%
% File:      implicit_principal_curvature_spheres.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.01.24
% Language:  MATLAB R2011b
% Purpose:   calculate center and radius of principal curvature sphere,
%            together with associated principal direction, at given points
% Copyright: Ioannis Filippidis, 2012-

g = grad;
H = Hessian;

[K, R, V] = implicit_principal_normal_curvatures(g, H);

n = size(K, 2);
qc = cell(1, n);
for i=1:n
    curx = x(:, i);
    curg = g(:, i);
    curR = R(:, i);
    
    curqc = find_curvature_sphere_center(curx, curg, curR);
    
    qc{1, i} = curqc;
end

function [qc] = find_curvature_sphere_center(x, g, R)
r = normvec(g, 'p', 2);

n = size(R, 1);
qc = nan(n +1, n);
for i=1:n
    Ri = R(i, 1);
    
    curqc = x -r *Ri /2;
    
    qc(:, i) = curqc;
end
