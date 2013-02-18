function [qinv, Dq_inv] = ginv(q, q0, r0)
%GINV   Wrapper for geometric_inversion. See that for help
%
% usage
%   [q, Dq] = ginv(q, q0, r0)
%
% 2013.02.03 (c) Ioannis Filippidis, jfilippidis@gmail.com
%
% See also geometric_inversion.

%% defaults
if nargin < 2
    ndim = size(q, 1);
    q0 = origin(ndim);
    disp('No center provided for inversion sphere: using origin.')
end

if nargin < 3
    r0 = 1;
    disp('No radius provided for inversion sphere: using unit sphere.')
end

% checks
if ~isscalar(r0)
    msg = ['inversion radius is not a scalar. For array r0 use ',...
           'directly function geometric_inversion.'];
    error(msg)
end

%% calc
if nargout == 2
    [qinv, Dq_inv] = geometric_inversion(q, q0, r0);
else
    qinv = geometric_inversion(q, q0, r0);
end