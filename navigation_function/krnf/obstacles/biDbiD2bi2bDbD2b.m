function [b, Db, D2b] = biDbiD2bi2bDbD2b(bi, Dbi, D2bi)
% File:      biDbiD2bi2bDbD2b.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.11.26
% Language:  MATLAB R2011b
% Purpose:   calculate obstacle product function and its derivatives from
%            individual obstacle functions and their derivatives
% Copyright: Ioannis Filippidis, 2011-

b = bi2b(bi);

if nargout == 2
    Db = Dbi2Db(Dbi, b, bi);
end

if nargout == 3
    D2b = D2bi2D2b(D2bi, Dbi, b, bi);
end
