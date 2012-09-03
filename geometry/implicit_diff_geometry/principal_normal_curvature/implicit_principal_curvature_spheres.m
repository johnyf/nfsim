function [qc, R, V] = implicit_principal_curvature_spheres(x, grad, Hessian)
%IMPLICIT_PRINCIPAL_CURVATURE_SPHERES   Principal curvature spheres.
%   Note that the principal curvature spheres have center half between the
%   point and the center of principal curvature and radius equal to half
%   the principal radius of curvature.
%
% usage
%   [qc, R, V] = IMPLICIT_PRINCIPAL_CURVATURE_SPHERES(x, grad, Hessian)
%
% input
%   x = calculation points
%     = [#dim x #pnts]
%   grad = implicit function gradient at calculation points
%        = [#dim x #pnts]
%   Hessian = Hessian matrices at calculation points
%           = {1 x #pnts} = {[#dim x #dim], ... }
%
% output
%   qc = centers of curvature spheres = x -n(x) *Ri(x) /2, where
%        n(x) is the outward unit normal at x, and
%        Ri(x) a principal radius of curvature
%      = [#dim x #pnts]
%   R = principal radii of curvature (sorted)
%     = [(#dim -1) x #pnts]
%   V = principal directions (sorted)
%     = [(#dim -1) x #pnts]
%
% reference
%   Filippidis, I.; Kyriakopoulos K.J.
%   Navigation Functions for Everywhere Partially Sufficiently Curved
%   Worlds
%   IEEE International Conference on Robotics and Automation,
%   St. Paul, Minnesota, USA, 2012 (ICRA'12)
%
% See also implicit_principal_normal_curvatures,
%          plot_implicit_principal_curvature_spheres,
%          plot_implicit_principal_curvature_circles,
%          implicit_focal_surface.
%
% File:      implicit_principal_curvature_spheres.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.01.24
% Language:  MATLAB R2011b
% Purpose:   calculate center and radius of principal curvature sphere,
%            together with associated principal direction, at given points
% Copyright: Ioannis Filippidis, 2012-

% depends
%   implicit_principal_normal_curvatures, normvec

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
