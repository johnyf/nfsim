function [obstacles] = ...
    create_heterogenous_obstacles(quadrics, inward_quadrics,...
                                  tori, supertoroids, halfspaces)
% CREATE_HETEROGENOUS_OBSTACLES     asseble heterogenous obstacles struct
%
% usage
%   [obstacles] = ...
%   create_heterogenous_obstacles(quadrics, inward_quadrics,...
%                                 tori, supertoroids, halfspaces)
%
% input
%   quadrics, inward_quadrics, tori, supertoroids = data structure arrays
%                       For definitions see 
%
% output
%   obstacles = structure array, with fields:
%       obstacles(1, i).type
%       obstacles(1, i).data
%
% See also BETA_HETEROGENOUS, PLOT_HETEROGENOUS_OBSTACLES.
%
% File:      create_heterogenous_obstacles.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.12.03
% Language:  MATLAB R2011b
% Purpose:   assemble heterogenous obstacles' structure
% Copyright: Ioannis Filippidis, 2011-

n = 0;
if ~isempty(quadrics)
    n = n +1;
    data{1, n} = quadrics;
    type{1, n} = 'quadrics';
end

if ~isempty(inward_quadrics)
    n = n +1;
    data{1, n} = inward_quadrics;
    type{1, n} = 'inward_quadrics';
end

if ~isempty(tori)
    n = n +1;
    data{1, n} = tori;
    type{1, n} = 'tori';
end

if ~isempty(supertoroids)
    n = n +1;
    data{1, n} = supertoroids;
    type{1, n} = 'supertoroids';
end

if ~isempty(halfspaces)
    n = n +1;
    data{1, n} = halfspaces;
    type{1, n} = 'halfspaces';
end

obstacles = struct('type', type, 'data', data);
