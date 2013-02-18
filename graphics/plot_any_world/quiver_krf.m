function [varargout] = quiver_krf(ax, domain, resolution, qd,...
                                   obstacles, k, vector_length)
%QUIVER_KRF    plot KRNF negated gradient field over 2D rectangular domain
%
% usage
%    H = QUIVER_KRF(domain, resolution, qd, obstacles, k, vector_length)
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
% 2012.01.22 - 2012.02.12 (c) Ioannis Filippidis, jfilippidis@gmail.com
%
% See also STREAKARROW_KRF, SURFC3_KRF, DOMAIN2GRAD_KRF, QUIVERMD.

if nargin < 7
    vector_length = 0.75;
end

[x, grad_krfx] = domain2grad_krf(domain, resolution, qd, obstacles, k);
g = -normvec(grad_krfx, 'p', 2);
h = quivermd(ax, x, g, vector_length);

grid(ax, 'on')
plot_scalings(ax, 0)
tex_plot_annot(ax, [], '$x$', '$y$', [], [] );

if nargout == 1
    varargout{1, 1} = h;
end
