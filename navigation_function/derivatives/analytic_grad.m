function [grad] = analytic_grad(type, varargin)
% File:      analytic_grad.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2010.10.02 - 2011.07.30
% Language:  MATLAB R2011b
% Purpose:   Analytical expression for scalar field gradient
% Copyright: Ioannis Filippidis, 2010-
%
% Note:
% It is not mandatory to use this selector, it is provided only to
% facilitate the user. The functions referenced here can be called
% directly.

switch type
    case 'khatib'
        grad = grad_khatib(varargin{:} );
    case 'krnfs'
        grad = normalized_grad_krnfs(varargin{:} );
    case 'krnf'
        grad = grad_krnf(varargin{:} );
    case 'polynomial'
        grad = grad_pnf(varargin{:} );
    otherwise
        error(['Unknown case for potential field method '...
            'analytical gradient function.'] )
end
