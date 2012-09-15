function [t] = predicates2indices(t, predicates)
%PREDICATE2INDEX    Convert predicate names to indices.
%
% usage
%   t = PREDICATES2INDICES(t, predicates)
%
% input
%   predicates = cell array of strings naming the predicates
%              = {p1, p2, ... } = {'...', '...', ... }
%
% See also csg, formula2parse_tree.
%
% File:      predicates2indices.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.09.08
% Language:  MATLAB R2012a
% Purpose:   find the index of each predicate and add a field 'index' to
%            each node of the tree which stores the index
% Copyright: Ioannis Filippidis, 2012-

n = t.nnodes;
for i=1:n
    curnode = t.Node(i);
    curnode = curnode{1};
    
    curpred = curnode.predicate;
    index = find(strcmp(curpred, predicates) );
    curnode.index = index;
    
    t = t.set(i, curnode);
end
