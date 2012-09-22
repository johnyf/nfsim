function [planes] = create_parallelepiped(x, L, pred)
%
% input
%   x = corner (lower left for rectangle)
%     = [#dim x 1]
%   L = side lengths of parallelepiped
%     = [1 x #dim]
%   pred = names of atomic propositions for geometric primitives
%        = cell array of strings (e.g., {'w1', 'w2', 'w3', 'w4'} )
%        = {1 x (2*#dim) }
%
% See also create_rectangle, create_halfspace, beta_halfspace,
%          plot_halfspace, init_room3d.

ndim = size(L, 2);

x0 = origin(ndim);
x1 = L.';

xp = [repmat(x0, 1, ndim), repmat(x1, 1, ndim) ];
xp = bsxfun(@plus, xp, x);

n = [eye(ndim), -eye(ndim) ];

Lx = L(1, 1);
Ly = L(1, 2);
Lz = L(1, 3);

domain = {[0, Lz, 0, -Ly], [0, Lz, 0, Lx], [0, -Ly, 0, Lx],...
          [-Lz, 0, -Ly, 0], [-Lz, 0, Lx, 0], [-Ly, 0, -Lx, 0] };

planes = create_halfspaces(xp, n, domain, pred);
