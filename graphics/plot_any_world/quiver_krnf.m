function [varargout] = quiver_krnf(ax, domain, resolution, qd,...
                                   obstacles, k, vector_length)
%QUIVER_KRNF    plot KRNF negated gradient field over 2D domain
%
% usage
%    H = QUIVER_KRNF(domain, resolution, qd, obstacles, k, vector_length)
%
% input
%   domain = [xmin, xmax, ymin, ymax]
%   resolution = [nx, ny]
%   qd = destination
%      = [#dim x 1]
%   obstacles = obstacle structure array as returned by
%               CREATE_HETEROGENOUS_OBSTACLES
%   k = tuning parameter
%   vector_length = length of vectors as fraction of grid length
%
% output
%   h = handle to quiver object
%
% See also STREAKARROW_KRNF, SURFC3_KRNF, DOMAIN2GRAD_KRNF, QUIVERMD.
%
% File:      quiver_krnf.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.01.22 - 2012.02.12
% Language:  MATLAB R2011b
% Purpose:   plot KRNF negated gradient field over 2D rectangular domain
% Copyright: Ioannis Filippidis, 2012-

if nargin < 7
    vector_length = 0.75;
end

[x, grad_krnfx] = domain2grad_krnf(domain, resolution, qd, obstacles, k);
g = -normvec(grad_krnfx, 'p', 2);
h = quivermd(ax, x, g, vector_length);

grid(ax, 'on')
plot_scalings(ax, 0)
tex_plot_annot(ax, [], '$x$', '$y$', [], [] );

if nargout == 1
    varargout{1, 1} = h;
end
