% File:      beta_phere0.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2010.11.12 - 
% Language:  MATLAB version 7.11 (2010b)
% Purpose:   World Boundary Lyapunov function
% Copyright: Ioannis Filippidis, 2010-

function [beta] = beta_phere0(q, qd, r0)
beta = beta0(q, r0);

beta0(qd, r0);

% nf values (many q)
%phiS = gd ./(gd.^k + beta).^(1/k);

function [beta] = beta0(q, r0)
% obstacle 0 (many q, single O0)
normq = vnorm(q, 1, 2).^ 2;
beta = r0.^2 -normq;

%beta(beta < 0) = 0;

if isempty( find(beta == 0, 1) ) == 0
    %warning('Configuration q or goal qg within obstacle!')
end
