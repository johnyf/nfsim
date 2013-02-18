function [A] = radii2ellipsoid(r)
%RADII2ELLIPSOID  Convert diagonals to ellipsoid symmetric matrix
%
% usage
%   A = radii2ellipsoid(r)
%
% input
%   r = row vector of ellipsoid radii (all > 0)
%     = [1 x #dim]
%     = [r1, r2, ..., r#dim]
%
% output
%   A = psd matrix defining quadratic form whose 0 level set is
%       the ellipsoid
%
% note
%   essentially r_k are the lengths of the ellipsoid semi-axes,
%   square roots of inverse eigs of the matrix A returned, i.e.,
%   the singular values of sqrt(A^-1)
%
% 2011.12.24 (c) Ioannis Filippidis, jfilippidis@gmail.com
%
% See also create_ellipsoid.

A = diag(1 ./r.^2);
