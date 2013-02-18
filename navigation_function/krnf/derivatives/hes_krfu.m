function [H] = hes_krfu(gd, Dgd, D2gd, b, Db, D2b, k)
%HES_KRFU  Un-squashed Koditschek-Rimon function Hessian matrix.
%
% usage
%   H = HES_KRFU(gd, Dgd, D2gd, b, Db, D2b, k)
%
% input
%   gd = destination function values at points q
%      = [1 x #points]
%   Dgd = destination function gradient column vectors at points q
%       = [#dimensions x #points]
%   D2gd = destination function Hessian matrices at points q
%        = {1 x #points}
%        = {[#dimensions x #dimensions], ..., }
%   b = obstacle function values at points q
%      = [1 x #points]
%   Db = obstacle function gradients at points q
%       = [#dimensions x #points]
%   D2b = obstacle function Hessian matrices at points q
%       = {1 x #points}
%       = {[#dimensions x #dimensions], ..., }
%   k = KRF tuning parameter
%     >= 2
%
% output
%   H = unsquashed KRNF Hessian at points q
%     = {1 x #points}
%     = {[#dimensions x #dimensions], ..., }
%
% 2012.07.03 (c) Ioannis Filippidis, jfilippidis@gmail.com
%
% See also krf, grad_krf, biDbiD2bi2bDbD2b.

check_krf_args(gd, b, k)

coef_D2gd = b .*(gd.^k +b).^(-1/k -1);
coef_D2b = (-1/k .*gd .*(gd.^k +b).^(-1/k -1) );

coef_DgdDgdT = k .*(k -1) .*b.^(-1) .*gd.^(k -2);
coef_DbDbT = 2 .*b.^(-3) .*gd.^k;
coef_DgdDb_2sym = -k .*b.^(-2) .*gd.^(k -1);

npnt = size(gd, 2);
H = cell(1, npnt);

for i=1:npnt
    curDgd = Dgd(:, i);
    curDb = Db(:, i);
    
    DgdDgdT = curDgd *curDgd.';
    DbDbT = curDb *curDb.';
    DgdDb_2sym = curDgd *curDb.' +curDb *curDgd.';
    
    term = coef_DgdDgdT(1, i)    .*DgdDgdT ...
         + coef_DbDbT(1, i)      .*DbDbT ...
         + coef_DgdDb_2sym(1, i) .*DgdDb_2sym;

    H{1, i} = coef_D2gd(1, i) .*D2gd{1, i} ...
            + coef_D2b(1, i)  .*D2b{1, i} ...
            + term;
end
