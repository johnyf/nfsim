function [grad] = grad_free(q, qd)
%GRAD_FREE  Only squashed paraboloid destination attraction,
% used for initial navigation in unknown worlds
%
% usage
%   grad = GRAD_FREE(q, qd)
%
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
% Note: equivalent to beta = 1;,
% but in this case the initial control
% signal is unbounded in infinity, not here
%
% 2010.02.27 - 2011.07.30 (c) Ioannis Filippidis, jfilippidis@gmail.com
%
% See also NORMALIZED_GRAD_KRFS, KRFS.

[gd, Dgd] = gamma_d(q, qd); % many q, single qd
grad = bsxfun(@times, Dgd, (gd +1).^(-2) );
