function  [] = plot_implicit_principal_curvature_circles(ax, x, grad, Hessian)
%
% File:      plot_implicit_curvature_spheres.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.01.24
% Language:  MATLAB R2011b
% Purpose:   plots principal curvature circles in the subspace spanned by
%            the gradient and the associated principal direction
% Copyright: Ioannis Filippidis, 2012-

g = grad;
H = Hessian;

[qc, R, V] = implicit_principal_curvature_spheres(x, g, H);

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
givehold(ax, held)

function [] = plot_subspace_circles(ax, qc, R, V, g)
ncircles = size(qc, 2);
r = normvec(g, 'p', 2);
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
