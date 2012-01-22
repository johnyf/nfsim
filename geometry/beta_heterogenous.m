function [bi, Dbi, D2bi] = beta_heterogenous(q, obstacles)
%BETA_HETEROGENOUS  beta for heterogenous obstacle set at points q
%
% input
%   q = calculation point(s)
%   XCQUADRIC = centers of Quadric
%           = cell(1, #Quadric_obstacles)
%           = {[#dim x 1], ...}
%   AQ = definition matrices of Quadrics
%           = cell(1, #Quadric_obstacles)
%           = {[#dim x #dim], ...}
%   RQ = rotation matrices for ellipse reference frames
%           = cell(1, #Quadric_obstacles)
%           = {[#dim x #dim], ...}
% XCINWARDQUADRIC, AIQ, RIQ = similar definitions as for Quadric obstacles
%
% quadrics:         qc, R, A
% inward_quadrics:  qc, R, A
% tori:             qc, r, R, rot
% superellipsoids:  qc, a, e, R
% supertoroids:     qc, a, e, r, rot
%
% output
%   bi, Dbi, D2bi for sets of different obstacle types
% 
% See also BETA_QUADRICS, BETA_QUADRICS_INWARD, BETA_TORI,
%          BETA_SUPERELLIPSOIDS, BETA_SUPERTOROIDS.
%
% File:      beta_heterogenous.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.09.10 - 2011.12.23
% Language:  MATLAB R2011b
% Purpose:   implicit function value & gradient for
%            heterogenous obstacles
% Copyright: Ioannis Filippidis, 2011-

nobstacle_types = size(obstacles, 2);

bi = nan(0);
Dbi = cell(0);
D2bi = cell(1, 0);
for i=1:nobstacle_types
    switch obstacles(1, i).type
        case 'quadrics'
            quadrics = obstacles(1, i).data;
            [bi1, Dbi1, D2bi1] = beta_quadrics(q, quadrics);
            
            bi = [bi; bi1];
            Dbi = [Dbi; Dbi1];
            D2bi = [D2bi; D2bi1];
        case 'inward_quadrics'
            inward_quadrics = obstacles(1, i).data;
            [bi2, Dbi2, D2bi2] = beta_quadrics_inward(q, inward_quadrics);
            
            bi = [bi; bi2];
            Dbi = [Dbi; Dbi2];
            D2bi = [D2bi; D2bi2];
        case 'tori'
            tori = obstacles(1, i).data;
            [bi3, Dbi3] = beta_tori(q, tori);
            
            bi = [bi; bi3];
            Dbi = [Dbi; Dbi3];
        case 'superellipsoids'
            superellipsoids = obstacles(1, i).data;
            [bi4, Dbi4] = beta_superellipsoids(q, superellipsoids);
            
            bi = [bi; bi4];
            Dbi = [Dbi; Dbi4];
        case 'supertoroids'
            supertoroids = obstacles(1, i).data;
            [bi5, Dbi5] = beta_supertoroids(q, supertoroids);
            
            bi = [bi; bi5];
            Dbi = [Dbi; Dbi5];
        case 'halfspaces'
            halfspaces = obstacles(1, i).data;
            [bi6, Dbi6] = beta_halfspaces(q, halfspaces);
            
            bi = [bi; bi6];
            Dbi = [Dbi; Dbi6];
        otherwise
            error('Unknown obstacle type.')
    end
end
