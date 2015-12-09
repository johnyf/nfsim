function [] = check_ellipsoid(A)
% checks if matrix A defines a quadratic form (whose level set at value 1
% is the ellipsoid boundary we are interested in).
%
% input
%   A = matrix to be checked
%
% 2011.09.10-2012.02.14 (c) Ioannis Filippidis, jfilippidis@gmail.com

if ~issymmetric(A)
    error('An ellipsoid is defined by a symmetric matrix A.')
end

% includes ismatrix, issquare checks
if ~ispsd(A)
    error('An ellipsoid is defined by a positive definite matrix A.')
end
