function [qtraj] = int_traj_krnf_csg(q0, qd, obstacles, step, niter, k)
%INT_TRAJ_KRNF_CSG     Integrate KRNF trajectory for CSG obstacles.
%
% usage
%   qtraj = INT_TRAJ_KRNF_CSG(q0, qd, obstacles, step, niter, k)
%
% input
%   q0 = initial condition(s)
%      = [#dim x #(initial conditions) ]
%   qd = destination(s)
%      = [#dim x #destinations]
%   obstacles = struct array, see create_heterogenous
%   step = integration step
%        > 0
%   niter = maximal number of iterations
%         \in\naturals
%   k = Koditschek-Rimon function tuning parameter
%     >= 2
%
% See also navigate_rig.
%
% File:      int_traj_krnf_csg.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.09.11
% Language:  MATLAB R2012a
% Purpose:   integrate Koditschek-Rimon function trajectory using Euler
% Copyright: Ioannis Filippidis, 2012-

[ndim, nq0] = size(q0);
[ndimd, nqd] = size(qd);

if ndim ~= ndimd
    error('Different dimension of initial coditions and destinations.')
end

if (nqd ~= 1) && (nq0 ~= nqd)
    error('Different number of initial conditions and destinations.')
elseif (nqd == 1)
    qd = repmat(qd, 1, nq0);
end

%% integrate

% for each trajectory
qtraj = cell(nq0, 1);
for i=1:nq0
    disp(['Integrating trajectory: ', num2str(i) ] )
    
    curq0 = q0(:, i);
    curqd = qd(:, i);
    
    curqtraj = single_traj_solver(curq0, curqd, obstacles, step, niter, k);
    
    qtraj{1, i} = curqtraj;
end

function [qtraj] = single_traj_solver(q0, qd, obstacles, step, niter, k)
q = q0;
ndim = size(q, 1);
qtraj = nan(ndim, niter);
for i=1:niter
    disp(['  Iteration: ', num2str(i) ] )
    
    qtraj(:, i) = q;
    
    [bi, Dbi, D2bi] = beta_heterogenous(q, obstacles);
    
    formula_tree = obstacles.formula_tree;
    [b, Db] = biDbiD2bi2bDbD2b_csg(bi, Dbi, D2bi, formula_tree);
    
    [gd, Dgd] = gamma_d(q, qd);
    
    gradnf = grad_krnf(gd, Dgd, b, Db, k);
    
    q = q -normvec(gradnf) *step;
end
