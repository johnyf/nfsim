function [H] = analytic_hes(type, varargin)
% File:      analytic_hes.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.07.30 - 2011.11.27
% Language:  MATLAB R2011b
% Purpose:   Analytical expression for scalar field Hessian matrix
% Copyright: Ioannis Filippidis, 2010-
%
% Note:
% It is not mandatory to use this selector, it is provided only to
% facilitate the user. The functions referenced here can be called
% directly.

switch type
    case 'krnf'
        H = hes_krnf(varargin);
    otherwise
        error(['Unknown case for potential field method '...
            'analytical Hessian matrix function.'] )
end
