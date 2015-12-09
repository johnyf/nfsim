function [b, Db, D2b] = biDbiD2bi2bDbD2b_csg(bi, Dbi, D2bi, formula_tree)
%BIDBID2BI2BDBD2B_CSG   Constructive Solid Geometry between obstacles
%                       (implicitly defined).
%
% usage
%   [b, Db, D2b] = BIDBID2BI2BDBD2B_CSG(bi, Dbi, D2bi, formula_tree)
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
%   formula_tree = parse and indexed tree of propositional CSG formula,
%                  see add_csg_info.
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
% 2012.09.08 (c) Ioannis Filippidis, jfilippidis@gmail.com
%
% See also add_csg_info, beta_heterogenous, insert_values2tree, csg,
%          biDbiD2bi2bDbD2b, biDbiD2bi2bDbD2b_rvachev.

% depends
%   insert_values2tree, csg

formula_tree = insert_values2tree(formula_tree, bi, Dbi, D2bi);
value = csg(formula_tree);

b = value.bi;
Db = value.Dbi;
D2b = value.D2bi;
