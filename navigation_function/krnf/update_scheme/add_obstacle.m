function [known] = add_obstacle(newqc, newr, qcold, rold, q, qd, known)
%ADD_OBSTACLE(NEWQC, NEWR, QCOLD, ROLD, Q, QD, KNOWN) update k for newly
%discovered obstacle.
%
% See also newei, update_eu, k_update.
%
% File:      add_obstacle.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.02.27 - 2011.10.01
% Language:  MATLAB R2011a
% Purpose:   Main algorithm for adding a new obstacle and updating k
% Copyright: Ioannis Filippidis, 2011-

%%
% disp('New qc = ')
% disp(newqc)
% 
% disp('New r = ')
% disp(newr)
% 
% disp('Already in list qc = ')
% disp(qcold)
% 
% disp('Already in list r = ')
% disp(rold)

%% input
qcn = newqc;
rn = newr;

qc = qcold;
r = rold;

% obstacle 0
r0 = -r(r < 0);

% internal obstacles 1,2,...,M
qc = qc(:, r > 0);
r = r(r > 0);

%% calculate
% type of new obstacle?
if rn > 0
    % internal new obstacle
    disp('new obstacle = internal.')
    known.M = known.M +1;
    qc(:, known.M) = qcn;
    r(1, known.M) = rn;
    
    if known.imin == 0
        % obs0 known + internal (current or more internal)
        disp('new internal + 0th = (at least 1 internal) +(0th obstacle).')
        i = known.M;
        known = newei(i, qc, r, r0, known, qd, q);
        known = update_eu(i, qc, r, r0, known, qd);
    elseif known.imin == 1
        % obs0 unknown
        if known.M > 2
            % current discovered is 3rd or more
            disp('>2 internal, no 0th obstacle.')
            i = known.M;
            known = newei(i, qc, r, r0, known, qd, q);
            known = update_eu(i, qc, r, r0, known, qd); % was commented
        elseif known.M == 2
            % current discovered is 2nd, fix 1st
            disp('2 internal, no 0th obstacle, fix 1st.')
            for i=1:2
                known = newei(i, qc, r, r0, known, qd, q);
            end
            i = 2;
            known = update_eu(i, qc, r, r0, known, qd);
        elseif known.M == 1
            % single internal obstacle known
            disp('signle internal obstacle known.')
            known.ei21(1, 1) = ei21_calc(r(1,1) );
            lambda = 0.5;
            known.ei01(1, 1) = ei01_calc(lambda, qd, qc(:, 1), r(1, 1) );
            known.eiu(1, 1) = min( [known.ei21(1, 1), known.ei01(1, 1) ] );
            known.ei(1, 1) = 0.5 *(norm(q-qc(:,1), 2)^2 -r(1,1)^2);
            known.sQii = Qii_calc(1, r(1,1), known.ei(1, 1) ) +known.sQii;
        else
            error('Added internal obstacle, but M_z = 0.')
        end
    else
        error('i_min \notin \{0, 1\}.')
    end
else
    % 0th new obstacle (i.e., world boundary)
    disp('new obstacle = 0th.')    
    known.imin = 0;
    r0 = -rn;
    % memo: recenter coordinates
    known.e0u = r0^2 -norm(qd, 2)^2;
    known.e0 = 0.5 *(r0^2 -norm(q, 2)^2); % init e0
    known.sQii = Qii_calc(0, r0, known.e0) +known.sQii;
    
    if known.M > 1
        disp('    new 0th obstacle with at least 2 internal obstacles.')
        i = 0;
        known = update_eu(i, qc, r, r0, known, qd);
    elseif known.M == 1
        % obs0 and obs1 only, so obs1 needs proper init
        disp('    new 0 with 1 internal.')
        i = 1;
        known = newei(i, qc, r, r0, known, qd, q);
    elseif known.M == 0
        disp('    0th obstacle alone.')
    else
        error('M < 0')
    end
end

known = k_update(known, qd, qc, r, r0, q);
