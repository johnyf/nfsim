function  [] = plot_implicit_principal_curvature_circles(ax, x, grad, Hessian)
%PLOT_IMPLICIT_PRINCIPAL_CURVATURE_CIRCLES  Plot principal curvature
%   circles.
%
% usage
%   PLOT_IMPLICIT_PRINCIPAL_CURVATURE_CIRCLES(ax, x, grad, Hessian)
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
% See also PLOT_BETA_PRINCIPAL_CURVATURE_CIRCLES,
%          PLOT_IMPLICIT_PRINCIPAL_CURVATURE_SPHERES,
%          IMPLICIT_PRINCIPAL_CURVATURE_SPHERES.
%
% File:      plot_implicit_principal_curvature_circles.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.01.24
% Language:  MATLAB R2012a
% Purpose:   plots principal curvature circles in the subspace spanned by
%            the gradient and the associated principal direction
% Copyright: Ioannis Filippidis, 2012-

g = grad;
H = Hessian;

[qc, R, V] = implicit_principal_curvature_spheres(x, g, H);

% at each point
held = takehold(ax);
npnts = size(qc, 2);
for i=1:npnts
    curqc = qc{1, i};
    curR = R(:, i) /2;
    curV = V{1, i};
    curg = g(:, i);
    curx = x(:, i);
    
    quivermd(ax, curx, min(curR) *normvec(curg) )
    plotmd(ax, curx, 'r*')
    plot_subspace_circles(ax, curqc, curR, curV, curg);
end
restorehold(ax, held)

function [] = plot_subspace_circles(ax, qc, R, V, g)
ncircles = size(qc, 2);
r = normvec(g, 'p', 2);

% each principal curvature circle
for i=1:ncircles
    curqc = qc(:, i);
    curR = R(i, 1);
    curV = V(:, i);
    
    plot_subspace_circle(ax, curqc, curR, curV, r)
end

function [] = plot_subspace_circle(ax, qc, R, t, r)
% unit circle
npnt = 30;
unit_circle = unitcircle(npnt);
origin_circle = R .*unit_circle;
rotated_circle = [t, r] *origin_circle;
this_circle = bsxfun(@plus, rotated_circle, qc);
plotmd(ax, this_circle)
plotmd(ax, qc, 'b+')
