function [qtraj] = multi_int_traj_krf_csg(q0, qd, obstacles, k, step,...
    niter, econv)
%MULTI_INT_TRAJ_KRF_CSG     Simultaneously integrate multiple KRF
%   trajectories using Euler integration.
%
% usage
%   qtraj = MULTI_INT_TRAJ_KRF_CSG(q0, qd, obstacles, step)
%   qtraj = MULTI_INT_TRAJ_KRF_CSG(q0, qd, obstacles, step, niter, econv)
%
% input
%   q0 = initial condition(s)
%      = [#dim x #(initial conditions) ]
%   qd = destination(s)
%      = [#dim x #destinations]
%   obstacles = struct array, see create_heterogenous
%   k = Koditschek-Rimon function tuning parameter
%     >= 2
%   step = integration step
%        > 0
%   niter = maximal number of iterations
%         \in\naturals (default = 300)
%   econv = convergence tolerance for distance to destination
%         >0 | =0 (to disable the convergence test - default)
%
% 2012.09.11 - 2012.09.20 (c) Ioannis Filippidis, jfilippidis@gmail.com
%
% See also navigate_rig.

%% input
[ndim, ntraj] = size(q0);
[ndimd, nqd] = size(qd);

if ndim ~= ndimd
    error('Different dimension of initial coditions and destinations.')
end

if nqd ~= 1
    error('Multiple destinations not implemented yet - not needed, its easy.')
end

if nargin < 6
    niter = 300;
end

% no convergence tolerance ? => no test
if nargin < 7
    econv = 0;
end

%% integrate
qtraj = nan(ndim, niter, ntraj);
q = q0;
for i=1:niter
    disp(['  Iteration: ', num2str(i) ] )
    
    qtraj(:, i, :) = q;
    
    [bi, Dbi, D2bi] = beta_heterogenous(q, obstacles);
    
    formula_tree = obstacles.formula_tree;
    [b, Db] = biDbiD2bi2bDbD2b_csg(bi, Dbi, D2bi, formula_tree);
    
    [gd, Dgd] = gamma_d(q, qd);
    
    gradnf = grad_krf(gd, Dgd, b, Db, k);
    
    q = q -normvec(gradnf) *step;
    
    % convergence test
    %if norm(q -q_d, 2) < econv
    %    qtraj(:, i+1) = q;
    %    break
    %end
end

qtraj = qtraj_mat2cell(qtraj);

%qtraj = vremnan(qtraj, 1);

% single trajectory ? => return matrix
if size(qtraj, 2) == 1
    qtraj = qtraj{1, 1};
end
