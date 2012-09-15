function [t] = idx2str_tree(t)
t = t.treefun(@get_node_idx);

function [s] = get_node_idx(x)
s = x.index;
