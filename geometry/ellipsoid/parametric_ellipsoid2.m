function [q, res] = parametric_ellipsoid2(ellipsoid, npnt)
% Ellipsoid surface points, argument is ellipsoid struct,
% compare with arguments of parametric_ellipsoid.
%
%usage
%-----
%   [q, res, X, Y, Z] = parametric_ellipsoid2(torus, npnt)
%
%input
%-----
%   torus = struct defining the torus, see create_torus
%   npnt = number of surface points for plotting
%
%about
%-----
% 2012.09.02 (c) Ioannis Filippidis, jfilippidis@gmail.com
%
% See also parametric_ellipsoid, parametric_tous2.

%todo
%   use npnt

if nargin > 1
    dom = [0, 2*pi, 0, pi];
    res = [npnt, ceil(npnt/2) ];
    u = dom2vec(dom, res);
end

qc = ellipsoid.qc;
rot = ellipsoid.rot;
r = mat2radii(ellipsoid.A);

q = parametric_ellipsoid(u, qc, rot, r);