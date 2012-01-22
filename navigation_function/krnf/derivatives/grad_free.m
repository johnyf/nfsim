function [grad] = grad_free(q, qd)
% inputs
%   q = calculation points
%     = [#dimensions x #points]
%   qd = single destination
%      = [#dimensions x 1]
%
% outputs
%   grad = squashed parabolic gradient at points q
%        = [#dim x #points]
%
% See also NORMALIZED_GRAD_KRNFS, KRNFS.
%
% Note: equivalent to beta = 1;,
% but in this case the initial control
% signal is unbounded in infinity, not here
%
% File:      grad_free.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2010.02.27 - 2011.07.30
% Language:  MATLAB R2011a
% Purpose:   only squashed paraboloid destination attraction,
%            used for initial navigation in unknown worlds
% Copyright: Ioannis Filippidis, 2011-

[gd, Dgd] = gamma_d(q, qd); % many q, single qd
grad = bsxfun(@times, Dgd, (gd +1).^(-2) );
