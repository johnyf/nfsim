function  [] = plot_implicit_principal_curvature_spheres(ax, x, grad, Hessian)
%PLOT_IMPLICIT_PRINCIPAL_CURVATURE_SPHERES  Plot principal curvature
%   spheres.
%
% usage
%   PLOT_IMPLICIT_PRINCIPAL_CURVATURE_SPHERES(ax, x, grad, Hessian)
%
% input
%   ax = axes object handle
%   x = implicit surface points
%     = [#dim x #pnts]
%   grad = gradients of implicit function at x
%        = [#dim x #pnts]
%   Hessian = Hessian matrices of implicit function at x
%           = {1 x #pnts} = {[#dim x #dim], ... }
%
% reference
%   Filippidis, I.; Kyriakopoulos K.J.
%   Navigation Functions for Everywhere Partially Sufficiently Curved
%   Worlds
%   IEEE International Conference on Robotics and Automation,
%   St. Paul, Minnesota, USA, 2012 (ICRA'12)
%
% See also PLOT_BETA_PRINCIPAL_CURVATURE_SPHERES,
%          PLOT_IMPLICIT_PRINCIPAL_CURVATURE_CIRCLES,
%          IMPLICIT_PRINCIPAL_CURVATURE_SPHERES.
%
% File:      plot_implicit_principal_curvature_spheres.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.01.29
% Language:  MATLAB R2012a
% Purpose:   plot the principal curvature spheres of an implicit surface
% Copyright: Ioannis Filippidis, 2012-

g = grad;
H = Hessian;

[qc, R, ~] = implicit_principal_curvature_spheres(x, g, H);

held = takehold(ax);
npnts = size(qc, 2);
for i=1:npnts
    curqc = qc{1, i};
    curR = R(:, i) /2;
    curg = g(:, i);
    curx = x(:, i);
    
    quivermd(ax, curx, min(curR) *normvec(curg) )
    plotmd(ax, curx, 'r*')
    plot_curvature_spheres(ax, curqc, curR);
end
restorehold(ax, held)

function [] = plot_curvature_spheres(ax, qc, R)
ncircles = size(qc, 2);
for i=1:ncircles
    curqc = qc(:, i);
    curR = R(i, 1);
    
    plot_curvature_sphere(ax, curqc, curR)
end

function [] = plot_curvature_sphere(ax, qc, R)
% unit circle
plot_sphere(ax, qc, R)
plotmd(ax, qc, 'b+')
