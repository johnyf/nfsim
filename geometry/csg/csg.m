function [f] = csg(t)
%CSG    Implicit Constructive Solid Geometry.
%
% usage
%   f = CSG(t)
%
% input
%   t = parse tree of propositional formula containing values, see 
%
% output
%   f = resulting value
%
% See also formula2parse_tree, predicates2indices, insert_values2tree,
%          get_obstacle_predicates.
%
% File:      csg.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.09.08
% Language:  MATLAB R2012a
% Purpose:   implicit constructive solid geometry (any dimension)
% Copyright: Ioannis Filippidis, 2012-

% depends
%   unary_operator, binary_operator

curnodeid = 1;
stop = 0;
while stop == 0
    curnode = t.Node(curnodeid);
    curnode = curnode{1};
    
    maxchildren = curnode.maxchildren;
    
    %% predicate (happens only if root is a predicate, so terminate)
    if maxchildren == 0
        stop = 1;
    end
    
    %% unary operator ?
    if maxchildren == 1
        operator = curnode.predicate;
        ddisp(['Unary operator: ', operator] )
        if strcmp(operator, '!') == 0
            error('Unary propositional operand is not negation (=!).')
        end
        
        childid = t.getchildren(curnodeid);
        v = get_child_value(t, childid);
        
        % operand down there not evaluated ?
        if isempty(v)
            curnodeid = childid;
            ddisp('Operand not evaluated.')
            continue
        end
        
        % remove 1 child
        t = t.removenode(childid);
        
        % apply unary operator on 1 child
        v = unary_operator(v);
        curnode.value = v;
        
        t = t.set(curnodeid, curnode);
        curnodeid = t.getparent(curnodeid);
    end
    
    %% binary operator ?
    if maxchildren == 2
        operator = curnode.predicate;
        ddisp(['Binary operator:', operator] )
        if ~ismember(operator, {'&', '|'} )
            error('Binary propositional operand is not & or |.')
        end
        
        childid = t.getchildren(curnodeid);
        v1 = get_child_value(t, childid(1, 1) );
        
        % operand down there not evaluated ?
        if isempty(v1)
            curnodeid = childid(1, 1);
            ddisp('First operand not evaluated.')
            continue
        end
        
        v2 = get_child_value(t, childid(1, 2) );
        
        % operand down there not evaluated ?
        if isempty(v2)
            curnodeid = childid(1, 2);
            ddisp('Second operand not evaluated.')
            continue
        end
        
        % remove 2 childrens
        childid = sort(childid, 'descend');
        t = t.removenode(childid(1, 1) );
        t = t.removenode(childid(1, 2) );
        
        % apply binary operator on 2 children
        v = binary_operator(operator, v1, v2);
        curnode.value = v;
        
        t = t.set(curnodeid, curnode);
        curnodeid = t.getparent(curnodeid);
    end
    
    %% root reached ?
    if curnodeid == 0
        stop = 1;
    end
end

curnode = t.Node(1);
curnode = curnode{1};
f = curnode.value;

function [value] = get_child_value(t, childid)
% check child 1
childnode = t.Node(childid);
childnode = childnode{1};

value = childnode.value;
