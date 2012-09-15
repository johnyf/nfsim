function [q] = parametric_ellipsoid(u, qc, rot, r)
%% input
if nargin < 1
    qc = zeros(3, 1);
end

if nargin < 2
    rot = eye(3);
end

if nargin < 3
    r = ones(1, 3);
end

%% calc
ndim = size(qc, 1);

switch ndim
    case 3
        [q] = param_ellipsoid3d(u, qc, rot, r);
    case 4
        [q] = param_ellipsoid4d(u, qc, rot, r);
    otherwise
        error('3 or 4 dim.')
end

function [q] = param_ellipsoid4d(t, qc, rot, r)
a = r(1, 1);
b = r(1, 2);
c = r(1, 3);
d = r(1, 4);

u = t(1, :);
v = t(2, :);
w = t(3, :);

q = [a .*cos(u) .*cos(v) .*cos(w);
     b .*cos(u) .*cos(v) .*sin(w);
     c .*cos(u) .*sin(v);
     d .*sin(u) ];

q = local2global_cart(q, qc, rot);

function [q] = param_ellipsoid3d(t, qc, rot, r)
a = r(1, 1);
b = r(1, 2);
c = r(1, 3);

t = domain2vec(dom, res);

u = t(1, :);
v = t(2, :);

q = [a .*cos(u) .*cos(v);
     b .*cos(u) .*sin(v);
     c .*sin(u) ];

q = local2global_cart(q, qc, rot);
