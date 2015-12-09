function [H] = numhes(f, h)
% File:      numhes.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.06.03 - 2011.07.30
% Language:  MATLAB R2011a
% Purpose:   Koditschek-Rimon numerical Hessian (in C-space or model space)
% Copyright: Ioannis Filippidis, 2011-
%
% f = function(pt) where pt is returned by NUMHESPT, look there for help.
% h = scalar perturbation step. CAUTION: only scalar allowed here
%
% Comments:
%   Any diffeomorphism done before calling this function.
% Otherwise Jacobians should be available to calculate the Hessian in
% C-space.
%   If Jacobians are indeed available, then it is more accurate to call the
% analytic Hessian calculation HESSIAN_KRNF which works in model space.
%
% Note:
%   This function does not take advantage of the Hessian matrix symmetry to
%   reduce the algorithm's computational complexity.

% check h
if ~isscalar(h)
    error(['Numerical Hessian matrix calculation accepts only uniform '...
        'scalar perturbation step h (currently).'] )
end

ndim = (size(f, 2) )^0.5 -1; % #dimensions
H = zeros(ndim);

grad0 = numgrad(f(1, 1:(ndim +1) ), h); % grad here

% for each coordinate dimension
for i=1:ndim
    i1 = i *(ndim +1);
    idx = 1:(ndim +1);
    grad1 = numgrad(f(1, i1 +idx), h);
    
    % assign as row i of Hessian
    H(i, :) = (grad1 -grad0)' /h;
end
