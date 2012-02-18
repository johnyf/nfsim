function  [] = plot_implicit_principal_curvature_spheres(ax, x, grad, Hessian)
%
% File:      plot_implicit_principal_curvature_spheres.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.01.30
% Language:  MATLAB R2011b
% Purpose:   plots principal curvature spheres tangent to implicit surface
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
givehold(ax, held)

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

