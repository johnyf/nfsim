function [b, Db, D2b] = biDbiD2bi2bDbD2b(bi, Dbi, D2bi)
%BIDBID2BI2BDBD2B   multiple obstacle function values to their product
%   [B, DB, D2B] = BIDBID2BI2BDBD2B(BI, DBI, D2BI) converts multiple
%   obstacle function values BI, geadients DBI and Hessian matrices D2BI
%   to the function values B, gradients DB and Hessian matrices D2B of
%   their product. The arguments BI, DBI, D2BI are as returned by
%   function BETA_HETEROGENOUS.
%
% See also BETA_HETEROGENOUS, BI2B, DBI2DB, D2BI2D2B.
%
% File:      biDbiD2bi2bDbD2b.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.11.26 - 2012.01.22
% Language:  MATLAB R2011b
% Purpose:   calculate obstacle product function and its derivatives from
%            individual obstacle functions and their derivatives
% Copyright: Ioannis Filippidis, 2011-

b = bi2b(bi);

if nargout >= 2
    Db = Dbi2Db(b, bi, Dbi);
end

if nargout == 3
    if any(b == 0)
        warning('nfsim:conversion', ['Db as implemented now can only ',...
            'synthesize Dbi, bi using b information for multiple ',...
            'obstacles only in the free sapce interior.',...
            'On an obstacle boundary it returns NaN'] )
    end
    D2b = D2bi2D2b(b, bi, Db, Dbi, D2bi);
end
