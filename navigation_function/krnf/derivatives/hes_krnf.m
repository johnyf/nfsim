function [H] = hes_krnf(gd, Dgd, D2gd, b, Db, D2b, k)
% inputs
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
%   k = KRNF tuning parameter
%     >= 2
%
% outputs
%   H = KRNF Hessian at points q
%     = {1 x #points}
%     = {[#dimensions x #dimensions], ..., }
%
% See also krnf, grad_krnf, biDbiD2bi2bDbD2b.
%
% File:      hes_krnf.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.06.02 - 2011.11.28
% Language:  MATLAB R2011b
% Purpose:   Koditschek-Rimon Navigation Function Analytical Hessian matrix
% Copyright: Ioannis Filippidis, 2011-

check_krnf_args(gd, b, k)

coef_D2gd = b .*(gd.^k +b).^(-1/k -1);
coef_D2b = (-1/k .*gd .*(gd.^k +b).^(-1/k -1) );
coef_term = - (gd.^k +b).^(-1/k -2);

coef_DgdDgdT = (k +1) .*b .*gd.^(k -1);
coef_DbDbT = (-1 /k .*(1 /k +1) .*gd);
coef_DgdDb_2sym = (-gd.^k +b /k);

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
            + coef_term(1, i) .*term;
end
