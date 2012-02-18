function [bi, Dbi, D2bi] = beta_heterogenous(q, obstacles)
%BETA_HETEROGENOUS  beta for heterogenous obstacle set at points q
%
% input
%   q = calculation point(s)
%   obstacles = obstacle definitions by type
%             = [1 x #types] (structure array with fields .type, .data)
%
%   qc = quadric centers
%           = cell(1, #Quadric_obstacles)
%           = {[#dim x 1], ...}
%   A = quadric definition matrix
%           = cell(1, #Quadric_obstacles)
%           = {[#dim x #dim], ...}
%   rot = reference frame rotation matrix
%           = cell(1, #Quadric_obstacles)
%           = {[#dim x #dim], ...}
%
% quadrics:         qc, rot, A
% inward_quadrics:  qc, rot, A
% tori:             qc, r, R, rot
% superellipsoids:  qc, a, e, R
% supertoroids:     qc, a, e, r, rot
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
% See also BETA_SPHERES, BETA_QUADRICS, BETA_QUADRICS_INWARD, BETA_TORI,
%          BETA_CYLINDERS, BETA_HALFSPACES, BETA_HYPERBOLOIDS,
%          BETA_SUPERELLIPSOIDS, BETA_SUPERTOROIDS,
%          PLOT_HETEROGENOUS_OBSTACLES.
%
% File:      beta_heterogenous.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.09.10 - 2012.01.24
% Language:  MATLAB R2011b
% Purpose:   implicit function value & gradient for
%            heterogenous obstacles
% Copyright: Ioannis Filippidis, 2011-

nobstacle_types = size(obstacles, 2);
nobstacles = 0;
for i=1:nobstacle_types
    data = obstacles(1, i).data;
    
    n_this_obs_type = size(data, 1);
    nobstacles = nobstacles +n_this_obs_type;
end
npnt = size(q, 2);

bi = nan(nobstacles, npnt);
Dbi = cell(nobstacles, 1);
D2bi = cell(nobstacles, npnt);
n = 0;
for i=1:nobstacle_types
    type = obstacles(1, i).type;
    data = obstacles(1, i).data;
    
    switch type
        case 'quadrics'
            quadrics = data;
            [bi1, Dbi1, D2bi1] = beta_quadrics(q, quadrics);
            
            [bi, Dbi, D2bi, n] = add_biDbiD2bi(bi1, Dbi1, D2bi1, bi, Dbi, D2bi, n);
        case 'inward_quadrics'
            inward_quadrics = data;
            [bi2, Dbi2, D2bi2] = beta_quadrics_inward(q, inward_quadrics);
            
            [bi, Dbi, D2bi, n] = add_biDbiD2bi(bi2, Dbi2, D2bi2, bi, Dbi, D2bi, n);
        case 'tori'
            tori = data;
            [bi3, Dbi3, D2bi3] = beta_tori(q, tori);
            
            [bi, Dbi, D2bi, n] = add_biDbiD2bi(bi3, Dbi3, D2bi3, bi, Dbi, D2bi, n);
        case 'superellipsoids'
            superellipsoids = data;
            [bi4, Dbi4] = beta_superellipsoids(q, superellipsoids);
            
            [bi, Dbi, ~, n] = add_biDbiD2bi(bi4, Dbi4, [], bi, Dbi, D2bi, n);
        case 'supertoroids'
            supertoroids = data;
            [bi5, Dbi5] = beta_supertoroids(q, supertoroids);
            
            [bi, Dbi, ~, n] = add_biDbiD2bi(bi5, Dbi5, [], bi, Dbi, D2bi, n);
        case 'halfspaces'
            halfspaces = data;
            [bi6, Dbi6] = beta_halfspaces(q, halfspaces);
            
            [bi, Dbi, ~, n] = add_biDbiD2bi(bi6, Dbi6, [], bi, Dbi, D2bi, n);
        otherwise
            error('Unknown obstacle type.')
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
