function [obstacles] = create_heterogenous_obstacles(varargin)
% CREATE_HETEROGENOUS_OBSTACLES     asseble heterogenous obstacles struct
%
% usage
%   obstacles = create_heterogenous_obstacles('type', data,...)
%
% input
%   type = osbtacle type name in plural
%   data = structure array with fields depending on type.
%
% output
%   obstacles = structure array, with fields:
%       obstacles(1, i).type
%       obstacles(1, i).data
%
% example
%   obstacles = create_heterogenous_obstacles('ellipsoids', data1, 'tori',
%                                             data2)
%
% See also BETA_HETEROGENOUS, PLOT_HETEROGENOUS_OBSTACLES.
%
% File:      create_heterogenous_obstacles.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.12.03 - 2012.05.25
% Language:  MATLAB R2011b
% Purpose:   assemble heterogenous obstacles' structure
% Copyright: Ioannis Filippidis, 2011-

% ellipsoids, inward_ellipsoids, supercyclides
% tori, supertoroids, hyperboloids
% halfspaces, cylinders
% booth_lemniscates, twin_circles
% visibility_lemniscates, visibility_angle_obstacles

type = varargin(1:2:end);
data = varargin(2:2:end);

obstacles = struct('type', type, 'data', data);
