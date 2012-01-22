function known = newei(i, qc, r, r0, known, qd, q)
% File:      newei.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.02.27 - 2011.10.01
% Language:  MATLAB R2011a
% Purpose:   \varepsilon_i upper bounds for new obstacle
% Copyright: Ioannis Filippidis, 2011-

qci = qc(:, i);
ri = r(1, i);

% i = new obstacle
imin = known.imin;
M = known.M;

%% ei3
en3 = +inf;

% proximity to obs0
if imin == 0
    en3 = (norm(qci, 2) - r0)^2 -ri^2;
end

% proximity to other obs 1,...,M
for j=[1:(i-1), (i+1):M]
    qcj = qc(:, j);
    rj = r(1, j);
    
    temp = ei3j_calc(qci, qcj, ri, rj);
    
    % smaller?
    if temp < en3
        en3 = temp;
    end
end

en3 = 0.8 *en3;

%% ei2'
en21 = ei21_calc(ri);

%% ei23
en23 = ei23_calc(en3, en21);

%% ei2''
sQ = 0;
sb = 0;

if imin == 0
    j = 0;
    
    qcj = zeros(size(qci) );
    rj = r0;
    
    minbji = minbji_calc(i, j, qci, qcj, ri, rj, en23);
    Qji = Qji_calc(i, j, qci, qcj, ri, rj, en23);
    
    sQ = Qji +sQ;
    sb = minbji +sb;
end

for j=[1:(i-1), (i+1):M]
    qcj = qc(:, j);
    rj = r(1, j);
    
    minbji = minbji_calc(i, j, qci, qcj, ri, rj, en23);
    Qji = Qji_calc(i, j, qci, qcj, ri, rj, en23);
    
    sQ = Qji +sQ;
    sb = minbji +sb;
end

s1 = 0;

if imin == 0
    j = 0;
    
    qcj = zeros(size(qci) );
    rj = r0;
    
    Qji = Qji_calc(i, j, qci, qcj, ri, rj, en23);
    s1 = s1 +Qji *(sQ -Qji);
end

for j=[1:(i-1), (i+1):M]
    qcj = qc(:, j);
    rj = r(1, j);
    
    Qji = Qji_calc(i, j, qci, qcj, ri, rj, en23);
    s1 = s1 +Qji *(sQ -Qji);
end

en22 = ri /sqrt(2 *(sb +4 *s1) );

%% store 2
known.ai21(1, i) = sb;
known.ai22(1, i) = s1;
known.ai23(1, i) = sQ;

%% ei0'
lambda = 0.5;
en01 = ei01_calc(lambda, qd, qci, ri);

%% ei03
en03 = ei23_calc(en3, en01);

%% ei0''
gammadimin = gdimin_calc(i, qd, qci, ri, en03);

sQ = 0;
sb = 0;

% 0^{th} known?
if imin == 0
    j = 0;
    
    qcj = zeros(size(qci) );
    rj = r0;
    
    maxbji = maxbji_calc(i, j, qci, qcj, ri, rj, en03);
    Qji = Qji_calc(i, j, qci, qcj, ri, rj, en03);
    
    sQ = Qji +sQ;
    sb = maxbji +sb;
end

% other internal ~= new
for j=[1:(i-1), (i+1):M]
    qcj = qc(:, j);
    rj = r(1, j);
    
    maxbji = maxbji_calc(i, j, qci, qcj, ri, rj, en03);
    Qji = Qji_calc(i, j, qci, qcj, ri, rj, en03);
    
    sQ = Qji + sQ;
    sb = maxbji +sb;
end

s1 = 0;

if imin == 0
    j = 0;
    
    qcj = zeros(size(qci) );
    rj = r0;
    
    Qji = Qji_calc(i, j, qci, qcj, ri, rj, en03);
    s1 = s1 +Qji *(sQ -Qji);
end

for j=[1:(i-1), (i+1):M]
    qcj = qc(:, j);
    rj = r(1, j);
    
    Qji = Qji_calc(i, j, qci, qcj, ri, rj, en03);
    s1 = s1 +Qji *(sQ -Qji);
end

% memo: when negative do not apply ei02
en02 = 1 /(2 /sqrt(gammadimin) *sQ +4 *sQ^2 +4 *s1); %-sb);

% memo: fix this
% if sQ == inf
%     sQ = 0;
% end
% 
% if s1 == inf
%     s1 = 0;
% end

%% store 0
known.ai01(1, i) = sb;
known.ai02(1, i) = s1;
known.ai03(1, i) = sQ;
known.gammadimin(1, i) = gammadimin;

%% eiu
known.eiu(1, i) = min([en23, en03, en22, en02] );

%% arbitrarily select ei
% obstacle 1 existed?
%if size(known.ei, 2) < 1 %i
    % no, intialize it
known.ei(1, i) = 0.5 *(norm(q-qci, 2)^2 -ri^2);
%{
% todo: find out why this was placed here
else
    % yes, go on
    di = norm(q-qci, 2)^2 -ri^2;
    
    if (di < known.ei(1, i) ) && (known.eiu(1, i) <= known.ei(1, i) )
        known.eiold(1, i) = known.ei(1, i);
        known.ei(1, i) = 0.8 *known.eiu(1, i);

        Qiiold = Qii_calc(i, ri, known.eiold(1, i) );
        Qiinew = Qii_calc(i, ri, known.ei(1, i) );

        DQii = Qiinew -Qiiold;

        known.sQii = DQii +known.sQii;
    end
end
%}
known.sQii = Qii_calc(i, ri, known.ei(1, i) ) +known.sQii;

%% output
known.ei3(1, i) = en3;
known.ei21(1, i) = en21;
known.ei22(1, i) = en22;
known.ei23(1, i) = en23;
known.ei01(1, i) = en01;
known.ei02(1, i) = en02;
known.ei03(1, i) = en03;
