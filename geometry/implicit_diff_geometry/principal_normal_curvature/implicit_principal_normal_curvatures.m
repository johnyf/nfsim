function [K, R, V] = implicit_principal_normal_curvatures(grad, Hessian, sorted)
%IMPLICIT_PRINCIPAL_NORMAL_CURVATURES   Principal curvatures.
%   Computes the principal curvatures of the level set surface given the
%   gradient and Hessian matrix of the implicit function.
%
% usage
%   [K, R, V] = IMPLICIT_PRINCIPAL_NORMAL_CURVATURES(grad, Hessian)
%
% input
%   grad = implicit function gradient
%        = [#dim x #pnt]
%   Hessian = implicit function Hessian matrices
%           = {1 x #pnt} = {[#dim x #dim], ... }
%
% output
%   K = principal curvatures of implicitly defined surface (sorted)
%     = [(#dim -1) x #pnt]
%   R = principal radii of curvature of implicitly defined surface (sorted)
%     = [(#dim -1) x #pnt]
%   V = principal directions of implicitly defined surface
%     = {1 x #pnt} = {[#dim x (#dim -1) ], ... }
%       (in ambient space coordinates)
%
% reference
%   do Carmo, M.P.
%   Differential Geometry of Curves and Surfaces
%   Prentice Hall, 1976
%
% See also implicit_principal_curvature_spheres.
%
% File:      implicit_principal_normal_curvatures.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.01.24
% Language:  MATLAB R2011b
% Purpose:   calculate principal normal curvatures and directions
%            together with associated principal radii of normal curvature
% Copyright: Ioannis Filippidis, 2012-

% depends
%   normvec, reduced_orthogonal_projector

if nargin < 3
    sorted = 'sorted';
end

g = grad;
H = Hessian;

[ndim, npnt] = size(g);
K = nan(ndim -1, npnt);
R = nan(ndim -1, npnt);
V = cell(1, npnt);
if iscell(H)
    nH = size(H, 2);
    
    if nH ~= npnt
        error('Gradients and Hessian matrices for different # points.')
    end
    
    for i=1:npnt
        curH = H{1, i};
        curg = g(:, i);
        
        [curK, curR, curV] = calc_curvature(curg, curH, sorted);
        
        K(:, i) = curK;
        R(:, i) = curR;
        V(1, i) = curV;
    end
else
    [K, R, V] = calc_curvature(g, H, sorted);
end

function [K, R, V] = calc_curvature(g, H, sorted)
% tangent plane well-defined ?
if norm(g) == 0
    K = nan;
    R = nan;
    V = {nan};
    return
end

n = normvec(g, 'p', 2);

Pg = reduced_orthogonal_projector(n);
Hg = Pg.' *H *Pg;

[V, D] = eig(Hg);

e = diag(D);

K = e /norm(g, 2); % principal normal curvatures
R = 1 ./K; % principal radii of normal curvature

V = Pg *V; % surface tangent space in ambient space coordinates

%% sort output
if ~strcmp(sorted, 'none')
    [K, I] = sort(K, 1);
    R = R(I);
    V = V(:, I);
end

V = {V};
