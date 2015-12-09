function [q, res, X, Y, Z] = parametric_torus2(torus, npnt)
%PARAMETRIC_TORUS2  Generate a torus.
%
% usage
%   [q, res, X, Y, Z] = PARAMETRIC_TORUS2(torus, npnt)
%
% input
%   torus = struct defining the torus, see create_torus
%   npnt = number of surface points for plotting
%
% File:      parametric_torus2.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.09.02
% Language:  MATLAB R2012a
% Purpose:   generate points on a torus
% Copyright: Ioannis Filippidis, 2010-

qc = torus.qc;
r = torus.r;
R = torus.R;
rot = torus.rot;

[q, res, X, Y, Z] = parametric_torus(qc, r, R, rot, npnt);
