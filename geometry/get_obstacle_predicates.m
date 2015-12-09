function [predicates] = get_obstacle_predicates(obstacles)
%GET_OBSTACLE_PREDICATES    Get predicate names of obstacles.
% 
% See also csg, test_csg, insert_values2tree.
%
% File:      get_obstacle_predicates.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.09.09
% Language:  MATLAB R2012a
% Purpose:   extract column cell array of predicate names of obstacles
% Copyright: Ioannis Filippidis, 2012-

predicates = {};
ntypes = size(obstacles, 2);
for i=1:ntypes
    curdata = obstacles(1, i).data;
    curpredicates = {curdata.predicate}.';
    
    predicates = [predicates; curpredicates];
end

unique_pred = uniquecell(predicates);
npred = size(predicates, 1);
n_unique = size(unique_pred, 1);
if n_unique ~= npred
    n_duplicate = npred - n_unique;
    msg = ['There are ', num2str(n_duplicate), ' duplicate predicates.'];
    error(msg)
end
