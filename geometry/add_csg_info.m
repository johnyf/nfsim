function [obstacles] = add_csg_info(obstacles, infix_formula)
%ADD_CSG_INFO   Add Constructive Solid Geometry info to obstacles.
%
% usage
%   formula_tree = ADD_CSG_INFO(obstacles, infix_formula)
%
% input
%   obstacles = struct array containing obstacle definitions,
%               see beta_heterogenous
%   infix_formula = propositional formula over shape predicates
%                 = string
%
% output
%   obstacles = struct array augmented with 'predicates', 'formula',
%                'formula_tree'
%
% See also csg, formula2parse_tree, predicates2indices,
%               insert_values2tree, beta_heterogenous.
%
% File:      add_csg_info.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.09.10
% Language:  MATLAB R2012a
% Purpose:   add constructive solid geometry info to obstacle struct array
% Copyright: Ioannis Filippidis, 2012-

% depends
%   get_obstacle_predicates, formula2parse_tree, predicates2indices, idx2str_tree

% todo
%   more elegant struct for obstacles

predicates = get_obstacle_predicates(obstacles);
formula_tree = formula2parse_tree(infix_formula);
formula_tree = predicates2indices(formula_tree, predicates);

%% output
obstacles(1).predicates = predicates;
obstacles(1).formula = infix_formula;
obstacles(1).formula_tree = formula_tree;

%% show info
s = idx2str_tree(formula_tree);
disp('The indexed tree is:')
disp(s.tostring)
disp('----------------')
