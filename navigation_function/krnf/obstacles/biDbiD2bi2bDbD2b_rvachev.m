function [b, Db, D2b] = biDbiD2bi2bDbD2b_rvachev(bi, Dbi, D2bi, operation)
%BIDBID2BI2BDBD2B_RVACHEV   Rvachev function and derivatives for obstacles.
%
% usage
%   [b, Db, D2b] = BIDBID2BI2BDBD2B_RVACHEV(bi, Dbi, D2bi, operation)
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
%   operation = desired Rvachev operation
%             = 'equivalence' |
%               'not'| 'complement' | '!' | '~' |
%               'or' | 'union' | 'disjunction' | '||' | '|' |
%               'and' | 'intersection' | 'conjunction' | '&&' | '&'
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
% See also beta_heterogenous, bi2b_rvachev, dbi2db_rvachev, rvachev,
%          biDbiD2bi2bDbD2b, biDbiD2bi2bDbD2b_csg.
%
% File:      biDbiD2bi2bDbD2b_rvachev.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.01.15 - 2012.01.27
% Language:  MATLAB R2011b
% Purpose:   calculate obstacle rvachev conjunction and its derivatives from
%            individual obstacle functions and their derivatives
% Copyright: Ioannis Filippidis, 2012-

% dependency
%   bi2b_rvachev, Dbi2Db_rvachev, D2bi2D2b_rvachev

if nargin < 4
    operation = 'and';
end
type = 'p';
a = 2;

b = bi2b_rvachev(bi, operation, type, a);

if 1 < nargout
    Db = Dbi2Db_rvachev(bi, Dbi, operation, type, a);
end

if 2 < nargout
    D2b = D2bi2D2b_rvachev(bi, Dbi, D2bi, operation, type, a);
end
