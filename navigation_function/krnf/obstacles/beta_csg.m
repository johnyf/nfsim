function [b, Db, D2b] = beta_csg(q, obstacles, else_rvachev)
%BETA_CSG   Obstacle function of model defined using constructive solid
%           geometry and Rvachev functions for the Boolean operations.
%
% usage
%   [b, Db, D2b] = BETA_CSG(q, obstacles)
%
% input
%   q = point coordinates where to compute obstacle function
%     = [#dim x #npnts]
%   obstacles = structure array of obstacles as returned by function
%               create_heterogenous_obstacles (see its help)
%
% optional input
%   else_rvachev = select if product or Rvachev conjunction used if no CSG
%                  formula parse tree found in obstacles [0:product]
%                = 0:product | 1:Rvachev
%
% output
%   bi = obstacle function values
%      = [#obstacles x #points]
%   Dbi = obstacle function gradients
%       = {#obstacles x 1} = {[#dim x #points]; ... }
%   D2bi = obstacle function Hessian matrices
%        = {#obstacles x #points}
%        = {[#dim x #dim], ...; ... }
%
% 2012.07.13 (c) Ioannis Filippidis, jfilippidis@gmail.com
%
% See also
%   biDbiD2bi2bDbD2b_csg
%   test_csg
%   beta_heterogenous
%   f_test_dist_rvachev
%   create_heterogenous_obstacles

%% input
if nargin < 3
    else_rvachev = 0;
    disp('No Rvachev option: using product.')
end

%% calc
[bi, Dbi, D2bi] = beta_heterogenous(q, obstacles);

% CSG ?
if isfield(obstacles, 'formula_tree')
    disp('Found formula parse tree, using CSG.')
    formula_tree = obstacles.formula_tree;
    [b, Db, D2b] = biDbiD2bi2bDbD2b_csg(bi, Dbi, D2bi, formula_tree);
elseif else_rvachev == 1
    disp('No CSG formula parse tree: using Rvachev conjunction.')
    [b, Db, D2b] = biDbiD2bi2bDbD2b_rvachev(bi, Dbi, D2bi);
elseif else_rvachev == 0
    disp('No CSG formula parse tree: using product.')
    [b, Db, D2b] = biDbiD2bi2bDbD2b(bi, Dbi, D2bi);
end
