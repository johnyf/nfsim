function [vmapped] = jacobian_mapping_vectors(J, v)
%
% usage
%   vmapped = jacobian_mapping_vectors(J, v)
%
% input
%   J = Jacobian matrice(s)
%     = [#dim x #dim]
%     | {1 x #pnts} = {[#dim x #dim], ... }
%   v = vectors to transform
%     = [#dim x #pnts]
%
% output
%   vmapped = images of vectors under the tangent space transformation
%           = J.' *v
%           = [#dim x #pnts]
%
% 2013.02.02 (c) Ioannis Filippidis
%
% See also pol2cart_jacobian, hes2mat3d.

J = hes2mat3d(J);
JT = multitransp(J, 1); % use the transpose
vmapped = multiprod(JT, v, [1, 2], 1); % vmapped = J^.'* v
