function [inward_quadrics] = create_inward_quadrics(qc, rot, r)
%CREATE_INWARD_QUADRICS    create array of inward quadric structures
%   Same as CREATE_QUADRICS.
%
% See also CREATE_QUADRICS.
%
% File:      create_inward_quadrics.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.01.30
% Language:  MATLAB R2011b
% Purpose:   initializes structure array of inward ellipsoids
% Copyright: Ioannis Filippidis, 2011-

inward_quadrics = create_quadrics(qc, rot, r);
