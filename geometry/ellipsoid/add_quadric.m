function [quadrics] = add_quadric(quadric, quadrics)
%ADD_QUADRIC    add quadric to quadrics structure array
%   [quadrics] = ADD_QUADRIC(quadric, quadrics) adds the quadric structure
%   to the structure array quadrics and returns the result.
%
% usage
%   [quadrics] = ADD_QUADRIC(quadric, quadrics)
%
% input
%   quadric = ellipsoid structure, defined in CREATE_ELLIPSOID.
%   quadrics = structure array with ellipsoids, defined in CREATE_QUADRICS.
%
% output
%   quadrics = structure array with ellipsoids, which is the union of the
%              inputs.
%
%   See also CREATE_QUADRICS, CREATE_ELLIPSOID, ADD_TORUS.
%
% File:      add_quadric.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.12.03 - 
% Language:  MATLAB R2011b
% Purpose:   add quadric to array of quadrics
% Copyright: Ioannis Filippidis, 2011-

n = size(quadrics, 1);
n = n +1;

quadrics(n, 1).qc = quadric.qc;
quadrics(n, 1).A = quadric.A;
quadrics(n, 1).rot = quadric.rot;
