% File:         m_calc.m
% Programmer:   John Filippidis, Mechanical Engineer, jfilippidis@gmail.com
% Date:         2010.09.13
% Language:     MATLAB, program version: 7.11 (2010b)
% Purpose:      given number of bezier control points
%               return matrix m(1:N+1,1:N+1)
%               Note: based on bezier_curve.c by John Filippidis (c) 2008
% Copyright:    John Filippidis, 2010-

function [m] = m_calc(n_cp)
    % n_cp [-] = number of bezier curve control points
    N = n_cp - 1;
    
    m = zeros(n_cp, n_cp);

    r1 = 1;
    % this variable & r2 are used to compute (-1)^(j-i)=(-1)^(i+j)
    % without calling pow(-1,j-i)
    % which has computational complexity O(N) (as j-i->N)
    
    for i=0:N
        r2 = 1;
        for j=0:(N-i)
            m(i+1,j+1) = r1 *r2 *binomial_coef(N,j) *binomial_coef(j,i);  % uses Binomial Coefficients
            r2 = -r2;
        end
        r1 = -r1; % each increment of i causes sign change of (-1)^(j-i)
    end
    
    m1 = fliplr(m);
    m1 = m1 - diag(diag(m1));
    m1 = rot90(m1,-1);
    
    m = m + m1;
end

function [bi_coef] = binomial_coef(n,k)
    bi_coef = 1;
    
    if (k>n)
        bi_coef = 0;
        return;
    end
    
    if (k > (n/2))
        k = n-k; % faster
    end
    
    for i=1:k
        bi_coef = bi_coef * (n-k+i) /i;
    end
end
