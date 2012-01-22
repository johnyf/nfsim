function [maxbji] = maxbji_calc(i, j, qi, qj, ri, rj, ei)
% File:      maxbji_calc.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.02.27 - 2011.07.30
% Language:  MATLAB R2011a
% Purpose:   \max_{\overline{\mathcal{B}_i(\varepsilon_i) } }\{\beta_j \}
% Copyright: Ioannis Filippidis, 2011-

if i ~= j
    % i != j
    if i == 0
        %% i=0, j!=0
    else
        % i!=0
        if j == 0
            %% i!=0, j==0
            
            maxbji = rj^2 -(sqrt(ei +ri^2) -norm(qi, 2) )^2;
        else
            %% i!=0, j!=0, i!=j
            
            maxbji = (sqrt(ei +ri^2) +norm(qi -qj, 2) )^2 -rj^2;
        end
    end
else
    % i == j
    if i==0
        %% i==0==j
    else
        %% i==j!=0
    end
end
