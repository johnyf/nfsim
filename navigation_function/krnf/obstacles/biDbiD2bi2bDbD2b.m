function [b, Db, D2b] = biDbiD2bi2bDbD2b(bi, Dbi, D2bi)
%BIDBID2BI2BDBD2B   multiple obstacle function values to their product
%   [B, DB, D2B] = BIDBID2BI2BDBD2B(BI, DBI, D2BI) converts multiple
%   obstacle function values BI, geadients DBI and Hessian matrices D2BI
%   to the function values B, gradients DB and Hessian matrices D2B of
%   their product. The arguments BI, DBI, D2BI are as returned by
%   function BETA_HETEROGENOUS.
%
% usage
%   [b, Db, D2b] = BIDBID2BI2BDBD2B(bi, Dbi, D2bi)
%
% input
%   bi = values of obstacle functions at calculation points
%      = [#obstacles x #points]
%   Dbi = gradients of obstacle functions at calculations points
%       = {#obstacles x 1}
%       = {[#dim x #points]; ;;; }
%   D2bi = Hessian matrices of obstacle functions at calculation points
%        = {#obstacles x #points]
%        = {[#dim x #dim] ,,, ;;; }
%
% output
%   b = values of aggregate obstacle function at calculation points
%     = [1 x #points]
%   Dbi = gradients of aggregate obstacle function at calculation points
%       = [#dim x #points]
%   D2bi = Hessian matrices of aggregate obstacle function at calculation
%          points
%        = {1 x #points}
%        = {[#dim x #dim] ,,, }
%
% See also BETA_HETEROGENOUS, BI2B, DBI2DB, D2BI2D2B,
%          biDbiD2bi2bDbD2b_rvachev.
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
        warning('nfsim:conversion', ['D2b as implemented now can only ',...
            'synthesize Dbi, bi using b information for multiple ',...
            'obstacles only in the free space interior.',...
            'On an obstacle boundary it returns NaN'] )
    end
    D2b = D2bi2D2b(b, bi, Db, Dbi, D2bi);
end
