function [varargout] = streakarrow_krnf(ax, domain, resolution, qd, obstacles, k)
%STREAKARROW_KRNF    plot KRNF negated gradient field over 2D domain
%   Same as QUIVER_KRNF, but uses streakarrow function instead.
%   As a result it takes slightly more time, but produces an improved
%   result, therefore suits final image rendering (for publication etc).
%   For details regarding usage, please see quiver_krnf.
%
% usage
%   [varargout] = streakarrow_krnf(ax, domain, resolution, qd, obstacles, k)
%
% See also QUIVER_KRNF, SURFC3_KRNF, DOMAIN2GRAD_KRNF, QUIVERMD.
%
% File:      streakarrow_krnf.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.01.23
% Language:  MATLAB R2011b
% Purpose:   plot KRNF negated gradient field over 2D rectangular domain
% Copyright: Ioannis Filippidis, 2012-

[~, ~, X, Y, Gx, Gy] = domain2grad_krnf(domain, resolution, qd, obstacles, k);
Gx(isnan(Gx) ) = 0;
Gy(isnan(Gy) ) = 0;
Gx = -Gx;
Gy = -Gy;
h = streakarrow(ax, X, Y, Gx, Gy, 2, 1);

grid(ax, 'on')
plot_scalings(ax, 0)
tex_plot_annot(ax, [], '$x$', '$y$', [], [] );

if nargout == 1
    varargout{1, 1} = h;
end