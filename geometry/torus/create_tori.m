function [tori] = create_tori(qc, r, R, rot)

nobs = size(qc, 2);

if size(R, 1) ~= 1
    error('R is not a row matrix.')
end

if size(R, 2) ~= nobs
    error('R not equal in number with obstacles.')
end

if size(r, 1) ~= 1
    error('r is not a row matrix.')
end

if size(r, 2) ~= nobs
    error('r not equal in number with obstacles.')
end

%tori = [];
for i=1:nobs
    curqc = qc(:, i);
    curr = r(1, i);
    curR = R(1, i);
    currot = rot{1, i};
    
    tori(i, 1) = create_torus(curqc, curr, curR, currot);
end
