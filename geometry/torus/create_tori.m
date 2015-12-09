function [tori] = create_tori(qc, r, R, rot)
%input
%-----
%
%   qc = tori centers
%      = [#dim x #tori]
%   r = tori minor radii
%     = [1 x #tori] > 0
%   R = tori major diameters
%     = [1 x #tori] > 0
%   rot = tori axes rotation matrix
%       = {1 x #tori} = {rot1, rot2, ..., rot#tori}, where roti\in SO^3
%
%about
%-----
% (c) Ioannis Filippidis
%
% See also create_torus, beta_torus, beta_tori, plot_torus, plot_tori.

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
