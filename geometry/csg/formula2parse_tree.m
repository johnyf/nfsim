function [t] = formula2parse_tree(infix_formula)
%FORMULA2PARSE_TREE     Convert formula to parse tree.
%
% usage
%   t = FORMULA2PARSE_TREE(infix_formula)
%
% input
%   infix_formula = propositional formula in infix notation (spin syntax)
%
% output
%   t = parse tree (tree class)
%       witho nodes structs with fields 'predicate', 'id', 'maxchildren'
%
% See also csg, predicates2indices, parse2str_tree, tree.
%
% File:      formula2parse_tree.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.09.08
% Language:  MATLAB R2012a
% Purpose:   parse formula into a tree
% Copyright: Ioannis Filippidis, 2012-

% depends
%   spin2dstar_syntax, in2prefix, insert_spaces, tree (class fex 35623)
%   parse2str_tree

infix_formula = spin2dstar_syntax(infix_formula);
prefix_formula = in2prefix(infix_formula);
prefix_formula = insert_spaces(prefix_formula, 'ltl2dstar');
prefix_formula = strtrim(prefix_formula);

% parse prefix formula into a binary decision diagram

cur_parentid = 0;
cur_nodeid = 1;
while ~isempty(prefix_formula)
    [token, remain] = strtok(prefix_formula);
    prefix_formula = remain;
        
    % add as child of current node
    curnode.predicate = token;
    curnode.id = cur_nodeid;
    
    % predicate or operator ?
    if propositional_operator(token)
        % unary or binary ?
        if isunary(token)
            curnode.maxchildren = 1;
        else
            curnode.maxchildren = 2;
        end
    else
        % predicate
        curnode.maxchildren = 0;
    end
    
    % current root ?
    if cur_parentid == 0
        backtrack = 0;
    else
        backtrack = 1;
    end
    
    % backtrack until there is free space
    while backtrack
        curparent = t.Node(cur_parentid);
        curparent = curparent{1};
        curchildren = t.getchildren(cur_parentid);
        
        maxchildren = curparent.maxchildren;
        nchildren = size(curchildren, 2);
        
        % reached max children ? (of current parent)
        if maxchildren <= nchildren
            % backtrack
            cur_parentid = t.getparent(cur_parentid);
            backtrack = 1; % redundant, for clarity only
        else
            backtrack = 0;
        end
    end
    % else same parent
    
    %% add to tree
    % init tree ?
    if cur_parentid == 0
        t = tree(curnode);
    else
        t = t.addnode(cur_parentid, curnode);
    end
    
    cur_parentid = cur_nodeid;
    cur_nodeid = cur_nodeid +1;
end

% disp
tstr = parse2str_tree(t);
disp('The parsed tree is:')
disp(tstr.tostring)
disp('----------------')

function [a] = isunary(x)
if ismember(x, '!')
    a = 1;
else
    a = 0;
end

function [a] = propositional_operator(x)
% is x a string?
if ~ischar(x)
    error('Input is not a string.')
end

% is x a single character?
if ~isequal(size(x), [1, 1] )
    a = 0; % 1 char operators only
    return
end

operators = {'&', '|', '!'};
if ismember(x, operators)
    a = 1;
else
    a = 0;
end
