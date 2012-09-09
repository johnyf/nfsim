function [bi, Dbi, D2bi] = beta_heterogenous(q, obstacles)
%BETA_HETEROGENOUS  Implicit functions and derivatives for mixed obstacles.
%
% input
%   q = calculation point(s)
%   obstacles = obstacle definitions by type
%             = [1 x #types] (structure array with fields .type, .data)
%   where:
%       type = plural name of obstacle type (e.g. 'ellipsoids')
%       data = struct array with fields depending on type
%   
%   Table of obstacle types and associated data
%       Type               Data
%     quadrics:         qc, rot, A
%     inward_quadrics:  qc, rot, A
%     tori:             qc, r, R, rot
%     superellipsoids:  qc, a, e, R
%     supertoroids:     qc, a, e, r, rot
%
%   where:
%       qc = quadric centers
%          = cell(1, #Quadric_obstacles)
%          = {[#dim x 1], ...}
%       A = quadric definition matrix
%         = cell(1, #Quadric_obstacles)
%         = {[#dim x #dim], ...}
%       rot = reference frame rotation matrix
%           = cell(1, #Quadric_obstacles)
%           = {[#dim x #dim], ...}
%
% output
%   bi = obstacle function values
%      = [#obstacles x #points]
%   Dbi = obstacle function gradients
%       = {#obstacles x 1} = {[#dim x #points]; ... }
%   D2bi = obstacle function Hessian matrices
%        = {#obstacles x #points}
%        = {[#dim x #dim], ...; ... }
% 
% See also BETA_SPHERES, BETA_ELLIPSOIDS, BETA_INWARD_ELLIPSOIDS, BETA_TORI,
%          BETA_CYLINDERS, BETA_HALFSPACES, BETA_HYPERBOLOIDS,
%          BETA_SUPERELLIPSOIDS, BETA_SUPERTOROIDS,
%          PLOT_HETEROGENOUS_OBSTACLES.
%
% File:      beta_heterogenous.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.09.10 - 2012.05.25
% Language:  MATLAB R2012a
% Purpose:   implicit functions and derivatives for mixed obstacles
% Copyright: Ioannis Filippidis, 2011-

nobstacle_types = size(obstacles, 2);
nobstacles = 0;
for i=1:nobstacle_types
    data = obstacles(1, i).data;
    
    n_this_obs_type = size(data, 1);
    nobstacles = nobstacles +n_this_obs_type;
end
npnt = size(q, 2);

types_only_fun = {'booth_lemniscates', 'inward_booth_lemniscates', 'visibility_lemniscates'};
types_only_derivative = {'superellipsoids', 'supertoroids'};
types_full = {'ellipsoids', 'not_ellipsoids', 'tori', 'halfspaces'};

bi = nan(nobstacles, npnt);
Dbi = cell(nobstacles, 1);
D2bi = cell(nobstacles, npnt);
n = 0;
for i=1:nobstacle_types
    type = obstacles(1, i).type;
    data = obstacles(1, i).data;
    fname = ['beta_', type];
    
    switch type
        case types_only_fun
            bi1 = feval(fname, q, data);
            [bi, ~, ~, n] = add_biDbiD2bi(bi1, [], [], bi, Dbi, D2bi, n);
        case types_only_derivative
            [bi1, Dbi1] = feval(fname, q, data);
            [bi, Dbi, ~, n] = add_biDbiD2bi(bi1, Dbi1, [], bi, Dbi, D2bi, n);
        case types_full
            [bi1, Dbi1, D2bi1] = feval(fname, q, data);
            [bi, Dbi, D2bi, n] = add_biDbiD2bi(bi1, Dbi1, D2bi1, bi, Dbi, D2bi, n);
        otherwise
            warning('nfsim:beta:UnknownObstacles',...
                ['Unknown obstacle type: ', type] )
            bi2 = feval(fname, q, data);
            [bi, ~, ~, n] = add_biDbiD2bi(bi2, [], [], bi, Dbi, D2bi, n);
    end
end

function [bi, Dbi, D2bi, n] = add_biDbiD2bi(curbi, curDbi, curD2bi, bi, Dbi, D2bi, n)
m = size(curbi, 1);

n1 = n +1;
n2 = n +m;

rows = n1:n2;

bi(rows, :) = curbi;

% single obstacle gradients ?
if ~iscell(curDbi)
    curDbi = {curDbi};
end
Dbi(rows, 1) = curDbi;

D2bi(rows, :) = curD2bi;

n = n2;
