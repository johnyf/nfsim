function [hafspaces] = create_halfspaces(qp, n)

nobs = size(qp, 2);

if ~isequal(size(n), size(qp) )
    error('n does not correspond to the size of qp.')
end

hafspaces = [];
for i=1:nobs
    curqp = qp(:, i);
    curn = n(:, i);
    
    halfspace = create_halfspace(curqp, curn);
    
    hafspaces = add_halfspace(halfspace, hafspaces);
end
