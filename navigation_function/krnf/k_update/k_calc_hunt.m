% File:      k_calc_hunt.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.05.26 - 
% Language:  MATLAB version 7.11 (2011a)
% Purpose:   Koditschek-Rimon k tuning feedback law hunting critical points
% Copyright: Ioannis Filippidis, 2011-

% Caution: yet it is assumed that max(gd) is found for known obstacle 0.
%   Future version will work also for unbounded worlds

function [known] = k_calc_hunt(known, qd, qc, r, r0, q)
lambda = 1.1;

imin = known.imin;
M = known.M;
kold = known.k;

% 0 known
maxWsqrtgd = r0 +norm(qd, 2);

sQi = 0;

if imin == 0
    %% obstacle 0
    beta0 = r0.^2 - norm(q, 2).^2;
    Q0 = Qi_calc(0, r0, beta0);

    sQi = Q0;
end

%% internal obstacles
for i=1:M
    qi = qc(:, i);
    ri = r(1, i);

    betai = norm(q-qi, 2)^2 -ri^2;
    Qi = Qi_calc(i, ri, betai);
    
    sQi = Qi +sQi;
end

knew = lambda *maxWsqrtgd *sQi;

if knew > kold
    known.k = knew;
    disp(['k = ', num2str(knew) ] )
end
