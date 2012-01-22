function [Ua] = khatib(gd, bi, kp, eta, b0)
%KHATIB     Potential field function proposed by Khatib
%
% input
%   q = calculation point(s)
%     = [#dim x #points]
%   qd = destination
%      = [#dim x 1]
%   bi = obstacle function values @ q
%      = [#obstacles x #calculation points]
%   kp = attractive well multiplicative gain tuning parameter
%      >0
%   eta = repulsive scalar field multiplicative gain tuning parameter
%       >0
%   beta0 = cut-off threshold for obstacle function smooth switching
%       >0
%
% output
%   Ua = potential field scalar values @ q
%      = [1 x #points]
%   DUa = gradient of potential field @ q
%       = [#dim x #points]
%
%   Field function:
%   Analytic derivative:
%       potential values f_i of obstacle repulsive scalar fields or
%       sum of potential values f_i of obstacles fields or
%       potential values f_i and grad(f_i) or
%       sum of f_i and sum of grad(f_i)

% Note: implement implicit & distance forms separately

[kp, h, b0] = check_khatib_args(bi, kp, eta, b0);

%% destination attractive effect
Ud = 1/2 *kp *gd;

%% obstacle repulsive effect
% presently single obstacle repulsive potential implemented and it is left
% to the user's choice (and freedom) to select the composition method of
% individual obstacle implicit (generalized distance) functions bi. The
% available choices are in general product (KR), sum, Rvachev or other.

% FIRAS function
% (Force Inducing an Artificial Repulsion from the Surface - in French)
Uo = 1/2 .*h .*(1 ./bi -1 ./b0).^2;
Uo(bi < 0) = inf;
Uo(bi > b0) = 0; % smooth switch
Uo = sum(Uo, 1);

%% resultant field
Ua = Ud +Uo; % artificial resultant potential
