function [t] = parse2str_tree(t)
t = t.treefun(@get_node_token);

function [s] = get_node_token(x)
s = x.predicate;
