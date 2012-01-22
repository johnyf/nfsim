%% e0'
qd_qc = bsxfun(@minus, qd, qc);
e01 = w .*(vnorm(qd_qc, 1, 2).^2 -r.^2);
e01min = min(e01);

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
end

e02 = min(e02);

%% e0
e0 = min( [e01min, e02] );

%% e2i'
e21 = r.^2 ./2;
e21min = min(e21);

%% e2'' (OLD)
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

e22min = min(e22);

%% e2
e2 = min( [e21min, e22min] );

%% e
e = min( [e1, e2] );

%% k >= N(e)
A = sum( vnorm(qc, 1, 2));

k = 1/e * (r0 + norm(qd,2)) * ((M+1) *r0 +A);
