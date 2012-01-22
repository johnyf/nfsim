function [quadrics] = create_quadrics(qc, rot, r)

nobs = size(qc, 2);

if ~iscell(rot)
    error('R is not cell array.')
end

if size(rot, 2) ~= nobs
    error('R not equal in number with obstacles.')
end

if ~iscell(r)
    error('r is not cell array.')
end

if size(r, 2) ~= nobs
    error('r not equal in number with obstacles.')
end

quadrics = [];
for i=1:nobs
    curqc = qc(:, i);
    currot = rot{1, i};
    curr = r{1, i};
    
    quadric = create_ellipsoid(curqc, currot, curr);
    
    quadrics = add_quadric(quadric, quadrics);
end
