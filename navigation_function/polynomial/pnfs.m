function [nfs] = pnfs(q, qd, qc, r)
% File:      pnfs.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2010.09.18 - 2011.07.30
% Language:  MATLAB R2011a
% Purpose:   Navigation function in sphere world
% Copyright: Ioannis Filippidis, 2010-
%
% calculate nf value for q(x) that also corresponds to x
% ATTENTION: qd will have its own Voronoi cell!
% this cell remains unmodified, to ensure that qd does not need to be
% moved

q_qd = bsxfun(@minus, q, qd);
gammad = vnorm(q_qd, 1, 2) .^ 2;

[idx, e] = find_ei(q, qc, r);

zi = zeros(1, size(q,2));
zi(idx == -1) = 1.5; % points NOT within ANY obstacle effect zone

b = zeros(1, size(q,2));

idx_idx = find(idx ~= -1); % points within 1 obstacle effect zone
for k=1:size(idx_idx,2)
    i = idx_idx(1,k); % select point
    j = idx(1,i); % select obstacle
    rS = norm(q(:,i) - qc(:, j), 2); % distance from circle
    zi(1,i) = (rS - r(1, j)) /e(1,j);
end

% no point can be within a sphere!
if ~isempty( find(zi < 0, 1) )
    zi_neg = find(zi < 0, 1);
    error( ['zi = ' num2str( zi(zi_neg) ) ' < 0'] )
end

b = P(zi);
b(b > 1) = 1;

nfs = gammad ./(gammad + b);
