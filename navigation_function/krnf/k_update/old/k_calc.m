% File:      k_calc.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2010.08.20 - 
% Language:  MATLAB version 7.11 (2010b)
% Purpose:   Koditschek-Rimon parameter k lower bound calculation
% Copyright: Ioannis Filippidis, 2010-

function [k, e0u, e01, e02, e21, e22, e3] = k_calc(qd, qc, r0, r)
M = size(qc, 2); % number of internal obstacles 1,2,...,M

% no obstacle known
if isempty(r0) && isempty(qc)
    k = 2;
    e0u = [];
    e01 = [];
    e02 = [];
    e21 = [];
    e22 = [];
    e3 = [];
    return
end

% only 0 obstacle known
if (~isempty(r0)) && isempty(qc)
    e0u = r0^2 -norm(qd, 2)^2;
    k = (r0 + norm(qd,2)) *((r0 /e0u)^2 -1 /r0^2)^0.5;
    return
end

%% w \in (0,1)
w = 0.2;

%% Zones around obstacles remain within free space
%% e3

e31 = (r0 -vnorm(qc, 1, 2)).^2 -r.^2;

e32 = zeros(1,M);
for i=1:M
    idx = [1:i-1, i+1:M];
    rt = r(1, idx); % t=temp
    qct = qc(:, idx);
    
    qc_qct = bsxfun(@minus, qc(:,i), qct);
    x = (vnorm(qc_qct, 1, 2) -rt).^2 -r(1,i)^2;
    
    e32(1,i) = min(x,[],2);
end

e3 = 0.15 * min( [e31; e32] ,[],1);

%% Critical points near internal obstacles have at least 1 negative eigenvalue
%% e0i'
% i=1,2,...,M
qd_qc = bsxfun(@minus, qd, qc);
e01 = w .*(vnorm(qd_qc, 1, 2).^2 -r.^2);
e01 = min( [e01; e3], [], 1);

%% e0i''
% i=1,2,...,M
e02 = zeros(1,M);
for i=1:M
    e = e01(1,i);
    
    % Minima
    bijmin0 = abs( r0^2 -( (e+r(1,i)^2)^0.5 +norm(qc(:,i),2) )^2 );
    bijmin = zeros(1,M);
    for j=1:M
        if j==i
            continue;
        end
        bijmin(1,j) = ( (e+r(1,i)^2)^0.5 -norm(qc(:,i)-qc(:,j), 2) )^2 -r(1,j)^2;
        bijmax(1,j) = ( (e+r(1,i)^2)^0.5 +norm(qc(:,i)-qc(:,j), 2) )^2 -r(1,j)^2;
    end
    
    min_sqrt_gd_i = -(e+r(1,i)^2)^0.5 +norm(qd -qc(:,i),2);
    max_sqrt_gd_i = +(e+r(1,i)^2)^0.5 +norm(qd -qc(:,i),2);
    
    mingd = min_sqrt_gd_i^2;
    maxgd = max_sqrt_gd_i^2;
    
    % e0i''
    sum1 = zeros(1,M+1);
    for j=0:M
        if j==i
            continue;
        end
        
        if j~=0
            sum1(1,j) = 1/bijmin(1,j);
            sum2 = (1 /bijmin0 +(r0 /bijmin0)^2)^0.5;
        else
            sum1(1,M+1) = 1/bijmin0;
            sum2 = 0;
        end
        
        for m=1:M
            if m==j || m==i
                continue;
            end
            sum2 = sum2 +(1 /bijmin(1,m) +(r(1,m) /bijmin(1,m))^2)^0.5;
        end
        
        if j~=0
            sum1(1,j) = -sum1(1,j) + 2*(1 /bijmin(1,j) +(r(1,j) /bijmin(1,j))^2)^0.5 *sum2;
        else
            sum1(1,M+1) = -sum1(1,M+1) + 2*(1 /bijmin0 +(r0 /bijmin0)^2)^0.5 *sum2;
        end
    end
    
    idx = [1:(i-1), (i+1):M];
    S1 = sum1;
    S3 = sum(sqrt(1./bijmin(idx) +(r(idx)./bijmin(idx)).^2) );
    S4 = sum(1./bijmax(idx) );
    %{
    % Selection 1 (Intermediate)
    nominator = min_sqrt_gd_i *norm(qd -qc(:,i),2);
    denominator = max_sqrt_gd_i *S3 +maxgd *S3^2 +maxgd *sum(S1) -mingd *S4;
    %
    % Selection 2 (Worst)
    nominator = (norm(qd -qc(:,i),2)^2 -(e +r(1,j)^2) )^0.5;
    denominator = S3 +max_sqrt_gd_i *S3^2 +max_sqrt_gd_i *sum(S1) -min_sqrt_gd_i *S4;
    %}
    % Selection 3 (Best)
    nominator = 1;
    denominator = 1./min_sqrt_gd_i *S3 +S3^2 +sum(S1) -S4;
    %
    e02(1,i) = nominator /denominator;
end

e0 = min( [e01; e02], [], 1);

%% No critical points near external boundary
%% e0u
% i=0
e0u = r0^2 -norm(qd, 2)^2;

%% Critical points near internal obstacles are NOT degenerate
%% e2i'
% i=1,2,...,M
e21 = r.^2;
e21 = min( [e21; e3], [], 1);

%% e2i''
% i=1,2,...,M
e22 = zeros(1,M);
for i=1:M
    e = e21(1,i);
    
    % Minima
    bijmin0 = abs( r0^2 -( (e+r(1,i)^2)^0.5 +norm(qc(:,i),2) )^2 );
    bijmin = zeros(1,M);
    for j=1:M
        if j==i
            continue;
        end
        bijmin(1,j) = ( (e+r(1,i)^2)^0.5 -norm(qc(:,i)-qc(:,j), 2) )^2 -r(1,j)^2;
    end
    
    % e2i''
    sum1 = zeros(1,M+1);
    for j=0:M
        if j==i
            continue;
        end
        
        if j~=0
            sum1(1,j) = 1/bijmin(1,j);
            sum2 = (1 /bijmin0 +(r0 /bijmin0)^2)^0.5;
        else
            sum1(1,M+1) = 1/bijmin0;
            sum2 = 0;
        end
        
        for m=1:M
            if m==j || m==i
                continue;
            end
            sum2 = sum2 +(1 /bijmin(1,m) +(r(1,m) /bijmin(1,m))^2)^0.5;
        end
        
        if j~=0
            sum1(1,j) = sum1(1,j) + 4*(1 /bijmin(1,j) +(r(1,j) /bijmin(1,j))^2)^0.5 *sum2;
        else
            sum1(1,M+1) = sum1(1,M+1) + 4*(1 /bijmin0 +(r0 /bijmin0)^2)^0.5 *sum2;
        end
    end
    
    %disp( ['Sum = ' num2str(sum(sum1))] )
    %disp( ['e0i''= ' num2str( r(1,i) /(2 *sum(sum1))^0.5 )] )
    
    e22(1,i) = r(1,i) /(2 *sum(sum1))^0.5;
end

e2 = min( [e21; e22], [], 1);

%% ei = min(e0i', e0i'', e2i', e2i'', e3i)
% i=1,2,...,M
emin = min([e0; e2; e3],[],1);

%% No critical points away of the obstacles
%% k >= N(e0, e1, e2,..., eM)
k = (r0 + norm(qd,2)) *(((r0 /e0u)^2 -1 /r0^2)^0.5 +sum( ((r./emin).^2 +1./emin).^0.5) );

%% Output
disp( ['e1i = '     num2str(e0u)  ', i=0']         )
disp( ['e0i'' = '   num2str(e01) ', i=1,2,...,M'] )
disp( ['e0i'''' = ' num2str(e02) ', i=1,2,...,M'] )
disp( ['e2i'' = '   num2str(e21) ', i=1,2,...,M'] )
disp( ['e2i'''' = ' num2str(e22) ', i=1,2,...,M'] )
disp( ['e3i = '     num2str(e3)                 ] )
disp( ['e(min)i = ' num2str(emin)               ] )
disp( ['k = '       num2str(k)                  ] )

% Note: if they have 1 eigenvalue<0 and another 0, they are degenerate
% therefore non-degeneracy should be assured independently and when it
% holds the current one ensures the critical points cannot be local minima
