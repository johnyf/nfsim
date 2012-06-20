function [h, q] = plot_twin_circles(ax, qc, rho, npnt, varargin)
% See also BETA_TWIN_CIRCLES, PARAMETRIC_TWIN_CIRCLES, TEST_TWIN_CIRCLES.
%
% File:      plot_twin_circles.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.05.22
% Language:  MATLAB R2012a
% Purpose:   plot twin circles
% Copyright: Ioannis Filippidis, 2012-

if nargin < 4
    npnt = 100;
end

theta = linspace(0, 2*pi, npnt);
r = parametric_twin_circles(theta, qc, rho);

q = vpol2cart(theta, r);

h = plotmd(ax, q, varargin{:} );

if nargout < 1
    clear('h')
end
