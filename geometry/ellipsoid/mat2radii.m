function [r] = mat2radii(A)
% Convert quadratic form matrix to radii of ellipsoid of 0 level set
%
%usage
%-----
%   r = mat2radii(A)
%
%input
%-----
%   A = psd matrix defining quadratic form whose 0 level set is
%       the ellipsoid
%
%output
%------
%   r = vector of ellipsoid radii (all > 0)
%     = (1 x #dim)
%     = (r1, r2, ..., r#dim)
%
%about
%-----
% 2011.12.24 (c) Ioannis Filippidis, jfilippidis@gmail.com
%
% See also mat2radii, create_ellipsoid.

r = 1 ./sqrt(diag(A) );
