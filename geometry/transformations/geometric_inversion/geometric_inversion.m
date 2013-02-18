function [u, Du] = geometric_inversion(q, q0, r0, A)
%GEOMETRIC_INVERSION    Invert wrt sphere.
%
% usage
%   [u, Du] = GEOMETRIC_INVERSION(q, q0, r0, A)
%
% input
%   q = points to invert (e.g. surface points)
%     = [#dim x #pnts]
%   q0 = inversion sphere center
%      = [#dim x 1]
%   r0 = inversion sphere radius or ellipsoid
%      > 0 | r0 can also be [1 x #pnts], e.g. for different inversion radii
%        per z coordinate, in 3d cylindrical inversion
%   A = Gram matrix def inner product inducing norm for inversion
%     = psd matrix defining ellipsoid's quadratic form
%     = [#dim x #dim]
%
% output
%   u = inverted points (images of q under inversion)
%     = [#dim x #pnts]
%   Du = Jacobian matrices of the inversion T:q->u at q
%      = {1 x #pnts} = {[2x2] x #pnts}
%
% origin
%   from plot_dupin_cyclide_using_inversion
%
% 2013.01.23 Copyright Ioannis Filippidis
%
% See also test_geometric_inversion,
%          plot_dupin_cyclide_using_inversion.

% todo
%   exploit Jacobian symmetry during computation
%   Hessian computation (?)

%% input
if nargin < 1
    warning('ginv:pnts', 'No points provided for inversion.')
    return
end

if nargin < 2
    ndim = size(q, 1);
    q0 = origin(ndim);
    disp('No center provided for inversion sphere: using origin.')
end

if nargin < 3
    r0 = 1;
    disp('No radius provided for inversion sphere: using unit sphere.')
end

if nargin < 4
    ndim = size(q, 1);
    A = eye(ndim);
else
    check_psd(A)
end

% checks
ndim1 = size(q, 1);
ndim2 = size(q0, 1);
if ndim1 ~= ndim2
    error('Points q and inversion center q0 have different dimensions.')
end

%% calc

% transform
u = bsxfun(@minus, q, q0);
%normq = vnorm(q, 1, 2);
normq = norm_gram(u, A);
unitq = normvec(u, 'p', 2, 'dim', 1); % note the difference, coordinate vectors
% normalized using 2-norm to get ray direction, whereas distance counting
% is done with the metric defined by A

u = bsxfun(@rdivide, unitq, normq);
u = bsxfun(@times, r0.^2, u);
u = bsxfun(@plus, u, q0);

%% Jacobian(s)
if nargout < 2
    return
end

[ndim, npnt] = size(q);
Du = nan(ndim, ndim, npnt);
for i=1:ndim
    x = q(i, :);
    idx = omit(i, ndim);
    c = vnorm(q(idx, :), 1, 2);
    
    % diagonal term
    Du(i, i, :) = r0.^2 .*(-x.^2 +c.^2) ./normq.^4;
    
    % off-diagonal terms
    for j=idx
        y = q(j, :);
        
        Du(i, j, :) = (-2*r0.^2) .*x .*y ./normq.^4;
    end
end

% avoid warnings for apparently 2d arrays (single one)
if ndims(Du) ~= 3
    return
end

Du = mat2cell(Du, ndim, ndim, ones(1, npnt) );
Du = shiftdim(Du, 1);
