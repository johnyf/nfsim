% File:      k_calc_old.m
% Author:    Ioannis Filippidis, Mechanical Engineer, jfilippidis@gmail.com
% Date:      2010.08.20 - 
% Language:  MATLAB, program version: 7.11 (2010b)
% Purpose:   Koditschek-Rimon parameter k lower bound calculation
% Copyright: Ioannis Filippidis, 2010-

function [k] = k_calc_old(qd, qc, r, r0)
M = size(qc,2);

%% w \in (0,1)
w = 0.7;

%% e3

% F0 in F
temp1 = (r0 -vnorm(qc, 1, 2)).^2 -r.^2;
temp1 = min(temp1);

temp2 = +inf;
for i=1:M
    for j=1:M
        if (i ~= j)
            temp = (norm(qc(:,i) -qc(:,j), 2) -r(j))^2 -r(i)^2;
            if (temp < temp2)
                temp2 = temp;
            end
        end
    end
end

e3 = min( [temp1, temp2] );

%% e0'
qd_qc = bsxfun(@minus, qd, qc);
e01 = w .*(vnorm(qd_qc, 1, 2).^2 -r.^2);
e01 = min(e01);

%% e0''
e02 = zeros(1,M);
t = (r0 +vnorm(qc, 1, 2)).^2 -r.^2;
t0 = 2*r0;

prodt = t0 *prod(t);
for i=1:M
    qi = qc(:,i);
    ri = r(1,i);
    
    b = ones(1,M);
    for j=1:M
        if j==i
            continue;
        end
        a = sqrt(w*norm(qd-qi,2)^2 +(1-w)*ri^2) -norm(qi-qc(:,j),2);
        a = a^2 -r(1,j)^2;
        b(1,j) = a;
    end
    
    nominator = 2 *(norm(qd-qi,2)...
                   -sqrt(w*norm(qd-qi,2)^2 +(1-w)*ri^2)) *norm(qd-qi,2)...
                    *prod(b);
    
    nominator = nominator *(r0^2 ...
                -(sqrt(w*norm(qd-qi,2)^2 +(1-w)*ri^2) + norm(qi,2))^2);
    
    nominator = abs(nominator);
            
    denominator = (r0 +norm(qd,2))^2;
    
    prodt1 = prodt /t(1,i);
    
    term1 = 1/(1 +norm(qd,2) /r0) *prodt1 /t0;
    term2 = 2*r0 *prodt1 /t0;
    
    for j=1:M
        if j==i
            continue;
        end
        
        term1 = term1 + (r0 +norm(qc(:,j)) ) /(r0+norm(qd,2)) *prodt1 /t(1,j);
        term2 = term2 + 2 *(r0 +norm(qc(:,j),2) ) *prodt1 /t(1,j);
    end
    denominator = denominator *(2 *prodt1 *term1 +term2^2 ...
        +prodt1 *(4*r0)^(M-1) *(8*M^2 -6*M));
    
    e02(1,i) = nominator /denominator;
    
    e = e01;
    for j=1:M
        bijmin(1,j) = ( (e+r(1,j)^2)^0.5 -norm(qc(:,i)-qc(:,j), 2) )^2 -r(1,i)^2;
    end
    
    ax(1,i) = prod(bijmin);
end
ax
sum(ax)

e02 = min(e02);

%% e0
e0 = min( [e01, e02] );

%% e1
e1 = r0^2 -norm(qd, 2)^2;

%% e2'
e21 = r.^2;
e21 = min(e21) /2;

%% e2''
for i=1:M
    term1 = 1-((r(1,i)*2^0.5 +norm(qc(:,i),2)) /r0)^2;
    for j=1:M
        if j==i
            continue;
        end
        
        term1 = term1 * (((r(1,i) *2^0.5 -norm(qc(:,i)-qc(:,j),2)) /r0)^2 ...
            -(r(1,j) /r0)^2);
    end
    term1 = r0 *r(1,i) *sqrt(term1 /(8*M^2 -6*M)) /2^M;
    e22(1,i) = term1;
end

e22 = min(e22);

%% e2
e2 = min( [e21, e22] );

%% e
e = min( [e0, e1, e2] );

%% k >= N(e)
A = sum( vnorm(qc, 1, 2));

k = 1/e * (r0 + norm(qd,2)) * ((M+1) *r0 +A);

%% Output
disp( ['  e0'' = ' num2str(e01)] )
disp( ['  e0'''' = ' num2str(e02)] )
disp( ['e0 = ' num2str(e0)] )
disp( ['e1 = ' num2str(e1)] )
disp( ['  e2'' = ' num2str(e21)] )
disp( ['  e2'''' = ' num2str(e22)] )
disp( ['e2 = ' num2str(e2)] )
disp( ['e3 = ' num2str(e3)] )
disp( ['e = ' num2str(e)] )
disp( ['k = ' num2str(k)] )
