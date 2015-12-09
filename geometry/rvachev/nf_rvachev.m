function [phiS] = nf_rvachev(agent, world, known_world)
% File:      nf_rvachev.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2010.11.11 - 
% Language:  MATLAB version 7.11 (2010b)
% Purpose:   Rvachev Navigation Function
% Copyright: Ioannis Filippidis, 2010-

% CAUTION: it is now limited to sphere worlds, but it may be applied to any
% implicit representation of space

[xc, r] = convex2sphere_world(world, known_world);
x = agent.xcur;
xd = agent.xd;
r0 = -r(r < 0);
r = r(r > 0);
xc = xc(:, r > 0);

phiS = zeros(1, size(x,2));
R = zeros(size(xc,2), size(x,2));

[R0, gd] = phiSphere0(x, xd, r0, 2);

k = [3, 3, 3, 3, 3, 3, 3, 3];
for i=1:size(xc,2)
    R(i,:) = phiSphere(x, xd, xc(:,i), r(1,i), k(i));
end

nf = R0;
for i=1:size(xc,2)
    R1 = nf;
    R2 = R(i,:);
    nf = rvachev('intersection', R1, R2, 'p', 2); % ./(2-2^0.5);
end

%k = 2;
%nf = 1 -nf.^(1/k) ./gd;

max(nf);
min(nf);

phiS(1,:) = nf;
%phiS(1,:) = gd ./(gd.^2 +nf).^0.5;
