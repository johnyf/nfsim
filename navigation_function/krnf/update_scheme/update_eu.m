function [known] = update_eu(j, qc, r, r0, known, qd)
% File:      update_eu.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.02.27 - 2011.07.30
% Language:  MATLAB R2011a
% Purpose:   updates $\varepsilon_{iu}$ for each old obstacle because of a
%               new obstacle
% Copyright: Ioannis Filippidis, 2011-

% new =?
if j==0
    qj = zeros(size(qc, 1), 1);
    rj = r0;
else
    qj = qc(:, j);
    rj = r(1, j);
end

%imin = known.imin;
M = known.M;

for i=1:M
    % new
    if i==j
        continue
    end
    
    % already known
    qi = qc(:, i);
    ri = r(1, i);
    
    %% ei3
    ei3n = ei3j_calc(qi, qj, ri, rj);
    
    % smaller?
    if ei3n < known.ei3(1, i)
        known.ei3(1, i) = 0.8 *ei3n;
    end
    
    %% ei23
    if known.ei3(1, i) < known.ei23(1, i)
        known.ei23(1, i) = known.ei3(1, i);
    end
    
    %% ei2''
    minbni = minbji_calc(i, j, qi, qj, ri, rj, known.ei23(1, i) );
    Qni = Qji_calc(i, j, qi, qj, ri, rj, known.ei23(1, i) );
    
    known.ai21(1, i) = known.ai21(1, i) +1 /minbni;
    known.ai22(1, i) = known.ai22(1, i) +2 *Qni *known.ai23(1, i);
    known.ai23(1, i) = known.ai23(1, i) +Qni; % caution 3
    
    known.ei22(1, i) = rj /sqrt(2 *(known.ai21(1, i) +4 *known.ai22(1, i) ) );
    
    %% ei03
    if known.ei3(1, i) < known.ei03(1, i)
        known.ei03(1, i) = known.ei3(1, i);
    end
    
    %% ei0''
    maxbni = maxbji_calc(i, j, qi, qj, ri, rj, known.ei03(1, i) );
    Qni = Qji_calc(i, j, qi, qj, ri, rj, known.ei03(1, i) );
    
    known.ai01(1, i) = known.ai01(1, i) +1 /maxbni;
    known.ai02(1, i) = known.ai02(1, i) +2 *Qni *known.ai03(1, i);
    known.ai03(1, i) = known.ai03(1, i) +Qni; % caution 3
    
    sb = known.ai01(1, i);
    s1 = known.ai02(1, i);
    sQ = known.ai03(1, i);
    gammadimin = known.gammadimin(1, i); % retireve (less than current)
    
    known.ei02(1, i) = 1 /(2 /sqrt(gammadimin) *sQ +4 *sQ^2 +4 *s1); %-sb);

    %% eiu
    known.eiu(1, i) = min( [known.ei23(1, i), known.ei03(1, i), ...
        known.ei22(1, i), known.ei02(1, i)] );
end
