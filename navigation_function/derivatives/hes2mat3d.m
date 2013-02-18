function [b] = hes2mat3d(a)
% maps cell array (row) of matrices to a 3-dimensional "stack" of them
%
% 2013.02.02 (c) Ioannis Filippidis
%
% See also jacobian_mapping_vectors.

% maybe use multitransp ?

if ~iscell(a)
    b = a;
    return
end

a = shiftdim(a, -1);
b = cell2mat(a);
