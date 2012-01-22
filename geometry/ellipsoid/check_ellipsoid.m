function [] = check_ellipsoid(A)
if ndims(A) ~= 2
    error('An ellipsoid is defined by a 2-dimensional matrix A.')
end

n = size(A, 1);
m = size(A, 2);

if n ~= m
    error('An ellipsoid is defined by a square matrix A.')
end

if ~isequal(A, A')
    error('An ellipsoid is defined by a symmetric matrix A.')
end

if ~all(eig(A) > 0)
    error('An ellipsoid is defined by a positive definite matrix A.')
end
