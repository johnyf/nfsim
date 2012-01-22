function [D2bpp] = bspline_hessian_matrix(Dbpp)
% example:
%   [D2bpp] = bspline_hessian_matrix(Dbpp)

ndim = Dbpp.dim;
dir = eye(ndim); % direction

D2bpp = fndir(Dbpp, dir); % differentiate
D2bpp = fnchg(D2bpp, 'dim', [fnbrk(Dbpp, 'dim'), size(dir, 2) ] ); %reshape
