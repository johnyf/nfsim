function [DUa] = grad_khatib(Dgd, bi, Dbi, kp, eta, b0)

[kp, h, b0] = check_khatib_args(bi, kp, eta, b0);

DUd = 1/2 *kp *Dgd;
DUo = Dbi2Db_sum(bi, Dbi, h, b0);
DUa = DUd +DUo;
