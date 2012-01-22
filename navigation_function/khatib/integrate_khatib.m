function [qhist] = integrate_khatib(q0, qd, quadrics, kp, eta, b0,...
                                    maxiter, step)
ndim = size(qd, 1);
q = q0;
qhist = nan(ndim, maxiter);
for i=1:maxiter
    [bi, Dbi, ~] = beta_quadrics(q, quadrics);
    [~, Dgd] = gamma_d(q, qd);
    
    DUa = grad_khatib(Dgd, bi, Dbi, kp, eta, b0);
    
    q = q -normvec(DUa) *step;
    qhist(:, i) = q;
end
