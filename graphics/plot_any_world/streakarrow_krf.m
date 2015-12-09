function [varargout] = streakarrow_krf(ax, domain, resolution, qd, obstacles, k)
%STREAKARROW_KRF    plot KRF negated gradient field over 2D rectangle.
%
%   Same as QUIVER_KRF, but uses streakarrow function instead.
%   As a result it takes slightly more time, but produces an improved
%   result, therefore suits final image rendering (for publication etc).
%   For details regarding usage, please see quiver_krnf.
%
% usage
%   [varargout] = STREAKARROW_KRF(ax, domain, resolution, qd, obstacles, k)
%
% 2012.01.23 (c) Ioannis Filippidis, jfilippidis@gmail.com
%
% See also QUIVER_KRF, SURFC3_KRF, DOMAIN2GRAD_KRF, QUIVERMD.

[~, ~, X, Y, Gx, Gy] = domain2grad_krf(domain, resolution, qd, obstacles, k);
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