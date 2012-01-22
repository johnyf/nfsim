function [known] = k_update(known, qd, qc, r, r0, q)
% File:      k_update.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2010.11.12 - 2011.08.01
% Language:  MATLAB R2011a
% Purpose:   Koditschek-Rimon parameter k lower bound update if needed
% Copyright: Ioannis Filippidis, 2010-

% at least one obstacle is known

if strcmp(known.k_mode, 'manual')
    %warning('Manual mode: no k update.')
    return
end

% disp('Before k update.')
% disp(known)

imin = known.imin;
M = known.M;

klb1 = 2;

for i=1:M
    qi = qc(:, i);
    ri = r(1, i);

    di = norm(q-qi, 2)^2 -ri^2;

    if (di < known.ei(1, i) ) && (known.eiu(1, i) <= known.ei(1, i) )
        known.eiold(1, i) = known.ei(1, i);
        known.ei(1, i) = 0.8 *known.eiu(1, i);

        Qiiold = Qii_calc(i, ri, known.eiold(1, i) );
        Qiinew = Qii_calc(i, ri, known.ei(1, i) );

        DQii = Qiinew -Qiiold;

        known.sQii = DQii +known.sQii;
    end
end

% known 0?
if imin == 0
    %% 0 known
    klb2 = [];
    
    d0 = r0^2 -norm(q, 2)^2;
    
    % forward theoretical bound
    if (d0 < known.e0) && (known.e0u <= known.e0)
        known.e0old = known.e0;
        known.e0 = 0.8 *known.e0u;
        
        Q00old = Qii_calc(0, r0, known.e0old);
        Q00new = Qii_calc(0, r0, known.e0);
        
        DQ00 = Q00new -Q00old;
        
        known.sQii = DQ00 +known.sQii;
    end
    
    klb3 = (r0 +norm(qd, 2) ) *known.sQii;
else
    %% 0 unknown
    klb2 = M +1;
    
    %tempk = max( [klb1, klb2] );
    
    beta = 1;
    qi_qd = +inf;
    for i=1:M
        qi = qc(:, i);
        beta = beta *(norm(q -qi, 2) -r(1, i)^2);
        if norm(qi-qd,2) < qi_qd
            qi_qd = norm(qi-qd,2);
        end
    end
    %maxgdW = (4^M *norm(q-qd, 2)^(2 *tempk) /beta)^(1 /2 /(tempk -M) );
    
    a1 = 4^M /beta;
    a2 = norm(q-qd, 2)^2;
    
    if a1 <= 1
        a1 = a1^0;
    else
        a1 = a1^0.5;
    end
    
    if a2 <= 1
        a2 = a2^0.5;
    else
        a2 = a2^(0.5 *(M +1) );
    end
    
    % check this
    klb3 = max( [qi_qd, a1 *a2] ) *known.sQii;
    
%     maxgdW2 = maxgdW;
%     k4 = klb3;
%     while maxgdW2 > maxgdW1
%         maxgdW1 = maxgdW2;
%         
%         maxgdW2 = (4^M *norm(q-qd, 2)^(2 *k4) /beta)^(1 /2 /(k4 -M) );
%         
%         if maxgdW2 > maxgdW1
%             k4 = maxgdW2 *known.sQii;
%         end
%     end
%     disp('ok!!!!!!!!!!!!!!!!!!!')
end

disp('k_lower_bound:')
    disp( ['1 = ', num2str(klb1) ] )
    disp( ['2 = ', num2str(klb2) ] )
    disp( ['3 = ', num2str(klb3) ] )

known.k = max( [known.k, klb1, klb2, klb3] );

% disp('After k update.')
% disp(known)
