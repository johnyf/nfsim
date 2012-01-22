% File:      k_update_old.m
% Author:    Ioannis Filippidis, Mechanical Engineer, jfilippidis@gmail.com
% Date:      2010.11.12 - 
% Language:  MATLAB, program version: 7.11 (2010b)
% Purpose:   Koditschek-Rimon parameter k lower bound update if needed
% Copyright: Ioannis Filippidis, 2010-

function [known_world] = k_update_old(known_world, q, qd, qc, r0, r)
kold = known_world.k;

% find lower boundary on k (if needed)
if strcmp(known_world.update, 'needed')
    [k, e1u, e01, e02, e21, e22, e3] = k_calc(qd, qc, r0, r);
    known_world.e0u = e0u;
    known_world.e02 = e02;
    known_world.e22 = e22;
    known_world.e3 = e3;
else
    e0u = known_world.e0u;
    e02 = known_world.e02;
    e22 = known_world.e22;
    e3 = known_world.e3;
end

q_qc = bsxfun(@minus, q, qc);
normq_qc = vnorm(q_qc, 1, 2);
beta = normq_qc.^2 -r(1, 2:end).^2;

idx = known_world.idx; % list of obstacles which came closer than e3(i)
idx = or(idx, beta < e3);
known_world.idx = idx;

emin = e3;
emin(idx) = min([e02(idx); e22(idx); e3(idx)],[],1);
k = (r0 + norm(qd,2)) *(((r0 /e0u)^2 -1 /r0^2)^0.5...
    +sum( ((r(1,2:end)./emin).^2 +1./emin).^0.5) );

known_world.k = max( [k, kold] ); % store for later use
if kold < k
    disp( ['Increased k to ' num2str(known_world.k) '.'] )
end
known_world.update = 'unneeded';
