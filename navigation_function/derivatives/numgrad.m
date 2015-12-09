function [grad] = numgrad(f, h)
%NUMGRAD    Numerical gradient.
%   NUMGRAD(F, H) is the numerical gradient of function F calculated at
%   points perturbed by H from the gradient calculation point.
%
% inputs
%   f(1, 1) = potential field value at current point q
%   f(1, 2:end) = potential field values at nearby (perturbation) points
%               = [1 x #dimensions]
%
%   h = perturbation scalar step (1e-8) (be carefull to keep this small!)
%       In case different step lengths have been taken in each dimension,
%       then give the array of steps
%     = [#dimensions x 1]
%
% output
%   grad = numerical gradient of function F
%        = [#dim x 1]
%
% See also NUMGRADPT.
%
% File:      numgrad.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
%            based on code by Giannis Roussos
% Date:      2011.07.30 - 2011.09.20
% Language:  MATLAB R2011a
% Purpose:   numerical gradient of function
% Copyright: Ioannis Filippidis, 2010-

ndim = size(f, 2) -1; % #dimensions

% uniform step in each coordinate?
if size(h, 1) == 1
    h = h *ones(ndim, 1);
end

grad = (f(1, 2:end)' - f(1, 1) ) ./h;
