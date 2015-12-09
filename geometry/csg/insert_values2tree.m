function [t] = insert_values2tree(t, bi, Dbi, D2bi)
% File:      insert_values2tree.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.09.08
% Language:  MATLAB R2012a
% Purpose:   copy predicate values to corresponding tree nodes
% Copyright: Ioannis Filippidis, 2012-

n = t.nnodes;
for i=1:n
    curnode = t.Node(i);
    curnode = curnode{1};
    
    index = curnode.index;
    curnode.value = operand_value(bi, Dbi, D2bi, index);
    
    t = t.set(i, curnode);
end

function [curvalue] = operand_value(bi, Dbi, D2bi, index)
% operator ? (not operand)
if isempty(index)
    curvalue = [];
    return
end

% if operand
curbi = bi(index, :);
curDbi = Dbi{index, 1};
curD2bi = D2bi(index, :);

curvalue.bi = curbi;
curvalue.Dbi = curDbi;
curvalue.D2bi = curD2bi;
    