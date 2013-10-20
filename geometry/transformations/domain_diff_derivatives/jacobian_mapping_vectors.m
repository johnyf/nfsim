function [vmapped] = jacobian_mapping_vectors(J, v)
% vectorized mapping J.' *v between tangent spaces
% If
%   u = T(x),   x = T^{-1}(u)
%   g(u) = f(T^{-1}(u) ) = f(x(u) )
% then
%   \nabla_u g(u) = D_uT^{-1}(u).' \nabla_x f(x(u) )
%
%usage
%-----
%   vmapped = jacobian_mapping_vectors(J, v)
%
%input
%-----
%   J = Jacobian matrix (or matrices)
%     = [#dim x #dim]
%     | {1 x #pnts} = {[#dim x #dim], ... }
%   v = vectors to transform
%     = [#dim x #pnts]
%
%output
%------
%   vmapped = images of vectors under the tangent space transformation
%           = J.' *v
%           = [#dim x #pnts]
%
%about
%-----
% 2013.02.02 (c) Ioannis Filippidis
%
% See also pol2cart_jacobian, hes2mat3d.

J = hes2mat3d(J);
JT = multitransp(J, 1); % use the transpose
vmapped = multiprod(JT, v, [1, 2], 1); % vmapped = J^.'* v
