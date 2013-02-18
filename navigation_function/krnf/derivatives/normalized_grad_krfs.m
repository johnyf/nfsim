function [grad] = normalized_grad_krfs(q, qd, qc, r0, r, k)
% Koditschek-Rimon analytical formula for normalized gradient in
% (model) sphere world
%
% inputs
%   q = calculation points
%     = [#dimensions x #points]
%   qd = destination point
%      = [#dim x 1]
%   qc = internal sphere obstacle centers
%      = [#dim x #internal_spherical_obstacles]
%   r0 = zeroth obstacle radius
%      > 0 (or <=0 if undefined/unknown)
%   r = internal sphere obstacle radii
%     = [1 x #internal_spherical_obstacles]
%   k = KRF tuning parameter
%     >= 2
%
% outputs
%   grad = KRF gradient at points q
%        = [#dim x #points]
%
% 2010.10.02 - 2011.09.10 (c) Ioannis Filippidis, jfilippidis@gmail.com
%
% See also KRFS, GRAD_KRF, GRAD_FREE.

%% NO obstacle known
if isempty(qc) && (r0 <= 0)
    grad = grad_free(q, qd);
    return
end

%% some obstacles known
check_krfs_args(q, qd, qc, r0, r, k)

[gd, Dgd] = gamma_d(q, qd);
q_qd = Dgd /2;

% 0 obstacle (many q, single O0)
if isempty(r0)
    grad0 = zeros(size(q));
    dist0 = +inf;
else
    normq = vnorm(q, 1, 2);
    beta0 = r0.^2 - normq.^2;
    grad0 = -bsxfun(@rdivide, q, beta0);
    dist0 = r0 - normq;
end

% obstacles 1,...,M (per q, many qc)
n = size(q,2);
Wsum = zeros(size(q));
mindist = +inf(1, n);

% any internal obstacles?
if ~isempty(r)
    for i=1:n
        q_qc = bsxfun(@minus, q(:,i), qc);
        beta1toM = vnorm(q_qc, 1, 2).^2 -r.^2;
        dist = vnorm(q_qc, 1, 2) -r;

        Wq_qc = bsxfun(@rdivide, q_qc, beta1toM); % weighted vector sum...
        Wsum(:,i) = sum(Wq_qc, 2); % ...completed

        mindist(1,i) = min(dist);
    end
end

Wsum = Wsum +grad0;

% gradient, 1 vector per q, many q
coef = gd ./k;
grad = q_qd -bsxfun(@times, coef, Wsum);
% Note: 2(q_qd) -2 (q_qc) /beta so 2 is cleared due to normalization anyway

normgrad = normvec(grad);

step = min( [dist0, mindist] ) ./2;
if isinf(step)
    step = 1;
end

grad = normgrad .*step;
