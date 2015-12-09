function [qtraj] = int_traj_krf_csg(q0, qd, obstacles, k, step, niter, econv)
%INT_TRAJ_KRF_CSG     Integrate KRF trajectory for CSG obstacles.
%
% usage
%   qtraj = INT_TRAJ_KRF_CSG(q0, qd, obstacles, step)
%   qtraj = INT_TRAJ_KRF_CSG(q0, qd, obstacles, step, niter, econv)
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
% See also navigate_rig, multi_int_traj_krf_csg.

%% input
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

if nargin < 6
    niter = 300;
end

% no convergence tolerance ? => no test
if nargin < 7
    econv = 0;
end

%% integrate

% for each trajectory
% (serial integration, contrast with multi_int_traj_krf_csg)
qtraj = cell(nq0, 1);
for i=1:nq0
    disp(['Integrating trajectory: ', num2str(i) ] )
    
    curq0 = q0(:, i);
    curqd = qd(:, i);
    
    curqtraj = single_traj_solver(curq0, curqd, obstacles, step, niter, k, econv);
    
    qtraj{1, i} = curqtraj;
end

% single trajectory ? => return matrix
if size(qtraj, 2) == 1
    qtraj = qtraj{1, 1};
end

function [qtraj] = single_traj_solver(q0, qd, obstacles, step, niter, k, econv)
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
    
    gradnf = grad_krf(gd, Dgd, b, Db, k);
    
    q = q -normvec(gradnf) *step;
    
    % convergence test
    if norm(q -qd, 2) < econv
        qtraj(:, i+1) = q;
        break
    end
end

qtraj = vremnan(qtraj, 1);
