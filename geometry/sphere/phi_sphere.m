% File:      phi_sphere.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2010.11.11 - 
% Language:  MATLAB version 7.11 (2010b)
% Purpose:   Sphere Lyapunov function for Rvachev Composition
% Copyright: Ioannis Filippidis, 2010-

function [beta] = phi_sphere(q, qd, qc, r)
beta = betaO(q, qc, r);

betaO(qd, qc, r);

% nf values (many q)
%gd = gamma_d(q, qd);
%phiS = gd ./(gd.^k + beta).^(1/k);

function [beta] = betaO(q, qc, r)
% single obstacle (many q, single qc)
q_qc = bsxfun(@minus, q, qc);
beta = vnorm(q_qc, 1, 2).^2 -r.^2;

%beta(beta < 0) = 0;

if isempty( find(beta == 0, 1) ) == 0
    %warning('Configuration q or goal qg within obstacle!')
end
