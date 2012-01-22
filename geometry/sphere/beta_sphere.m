function [b, Db, D2b] = beta_sphere(q, qc, r)

% any spheres?
if isempty(r)
    error('No spheres given.')
end

q_qc = bsxfun(@minus, q, qc);
b = vnorm(q_qc, 1, 2).^2 -r.^2;

Db = 2 *q_qc;
[ndim, npnts] = size(q);

D2b = {2 *eye(ndim) };
D2b = repmat(D2b, 1, npnts);
