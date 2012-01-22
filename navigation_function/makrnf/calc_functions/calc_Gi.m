function [Gi] = calc_Gi(b, lambda, h)
n = size(b, 2);

%% all levels
Gl = nan(1, n);
for i=1:n
    % all relations of level i
    Rl = combnk(1:n, i);
    
    % # of all relations of level i
    nRl = size(Rl, 1);
    
    % Relation Proximity Function (RPF)
    bRjl = nan(nRl, 1);
    for j=1:nRl
        Rjl = Rl(j, :);
        bRjl(j, 1) = sum(b(1, Rjl) );
    end
    
    % Relation Verification Function (RVF)
    gRjl = nan(nRl, 1);
    for j=1:nRl
        bjl = bRjl(j, 1);
        bjlC = bRjl([1:(j-1), (j+1):nRl] , 1);
        
        BRjlC = prod(bjlC);
        
        gRjl(j, 1) = RVF(bjl, BRjlC, lambda, h);
    end
    
    Gl(1, i) = prod(gRjl);
end
Gi = prod(Gl, 2);

function [gjl] = RVF(bjl, Bjl, l, h)
gjl = bjl + l *bjl /(bjl +Bjl^(1/h) );
