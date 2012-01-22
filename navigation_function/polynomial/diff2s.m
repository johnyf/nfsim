function [q, qd, qc, r] = diff2s(x, xd, xc, r, r_in, r_out, idx)
% x, current configuration
% File:      diff2s.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2010.09.18 - 2011.07.30
% Language:  MATLAB R2011a
% Purpose:   Polynomial Diffeomorphism around closest sphere, given patch
%            radii
% Copyright: Ioannis Filippidis, 2010-
%
% xd, goal configuration
% xi, sphere center in configuration space
%     give [] if not within a Voronoi cell
%     this specifies ONLY the diffeomorphism
% ri, sphere radius in configuration space
% ei, width of annulus arouns sphere, in which the repulsive potential
%     is active
% r_in, radius on current ray of transformed patch Pi inner boundary
%     (obstacle boundary in configuration space)
% r_out, radius on current ray of transformed patch Pi outer boundary
%     (weighted Voronoi cell outer boundary selected here)

% Diffeomosphism applied
[q] = diffeomorphism(x, xc(:, idx), r(1, idx), r_in, r_out);
qd = xd; % same destination coordinate
qc = xc; % same obstacle centers
