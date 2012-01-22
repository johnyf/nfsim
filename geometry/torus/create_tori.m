function [tori] = create_tori(qc, r, R, rot)

nobs = size(qc, 2);

if ~iscell(R)
    error('R is not cell array.')
end

if size(R, 2) ~= nobs
    error('R not equal in number with obstacles.')
end

if ~iscell(r)
    error('r is not cell array.')
end

if size(r, 2) ~= nobs
    error('r not equal in number with obstacles.')
end

tori = [];
for i=1:nobs
    curqc = qc(:, i);
    curr = r{1, i};
    curR = R{1, i};
    currot = rot{1, i};
    
    torus = create_torus(curqc, curr, curR, currot);
    
    tori = add_torus(torus, tori);
end
